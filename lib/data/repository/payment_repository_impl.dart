import 'dart:io';

import 'package:bladderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/mapper/plan_mapper.dart';
import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:bladderly/domain/model/promo_result.dart';
import 'package:bladderly/domain/repository/payment_repository.dart';
import 'package:collection/collection.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl({
    required ApiClient apiClient,
    required InAppPurchase inAppPurchase,
    required DeviceInfoModel deviceInfoModel,
  })  : _apiClient = apiClient,
        _inAppPurchase = inAppPurchase,
        _deviceInfoModel = deviceInfoModel;

  final ApiClient _apiClient;
  final InAppPurchase _inAppPurchase;
  final DeviceInfoModel _deviceInfoModel;
  final _productDetailsStream = BehaviorSubject<List<ProductDetails>>.seeded(const []);

  @override
  Future<List<Plan>> getPlans() async {
    final products = await _inAppPurchase.queryProductDetails(Product.ids);

    if (Platform.isAndroid) {
      final activeProducts = products.productDetails.where((details) {
        return (details as GooglePlayProductDetails).rawPrice != 0.0; // except free trial for promo code
      }).toList();
      _productDetailsStream.add(activeProducts);
    } else {
      _productDetailsStream.add(products.productDetails);
    }

    return _productDetailsStream.value.map(PlanMapper.fromProdutDetails).toList();
  }

  @override
  Future<bool> purchasePlan({
    required String productId,
  }) {
    if (Platform.isAndroid) {
      return _purchasePlanAndroid(productId: productId);
    } else if (Platform.isIOS) {
      return _purchasePlanIOS(productId: productId);
    }

    return Future.value(false);
  }

  Future<bool> _purchasePlanAndroid({
    required String productId,
  }) async {
    final pastPurchases =
        await _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>().queryPastPurchases();

    final pastPurchase = pastPurchases.pastPurchases
        .firstWhereOrNull((e) => e.billingClientPurchase.isAutoRenewing && e.status == PurchaseStatus.purchased);

    final currentProduct = Product.values.firstWhereOrNull((product) => product.id == pastPurchase?.productID);
    final newProduct = Product.values.byName(productId);
    final replacementMode = currentProduct?.getReplacementModeByNewProduct(newProduct);

    final changeSubscriptionParam = pastPurchase == null
        ? null
        : ChangeSubscriptionParam(oldPurchaseDetails: pastPurchase, replacementMode: replacementMode);

    final productDetails = _productDetailsStream.value.firstWhere((element) => element.id == productId);

    return _inAppPurchase.buyNonConsumable(
      purchaseParam: GooglePlayPurchaseParam(
        productDetails: productDetails,
        changeSubscriptionParam: changeSubscriptionParam,
      ),
    );
  }

  Future<bool> _purchasePlanIOS({
    required String productId,
  }) async {
    final productDetails = _productDetailsStream.value.firstWhere((element) => element.id == productId);

    return _inAppPurchase.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: productDetails));
  }

  @override
  Future<PostPayResponse> verifyPayment({
    required String userId,
    required String productId,
    required String purchaseToken,
    required String receipt,
  }) async {
    final result = await _apiClient.checkPayment(
      request: PaymentCheckRequest(
        userId: userId,
        device: _deviceInfoModel.os,
        productId: productId,
        purchaseToken: purchaseToken,
        receipt: receipt,
      ),
    );

    return result.body!;
  }

  @override
  Future<void> purchaseWithoutIap({
    required String userId,
    required String productId,
  }) {
    return _apiClient
        .checkPayment(request: PaymentCheckRequest(userId: userId, device: _deviceInfoModel.os, productId: productId))
        .then((value) => value.body!);
  }

  @override
  Future<PromoResult> checkPromo({
    required String userId,
    required String code,
  }) async {
    final response = await _apiClient.checkPromo(userId: userId, code: code).then((response) => response.body!);

    return PromoResult(result: response.result!, popup: response.popup!);
  }
}
