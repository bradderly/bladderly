import 'dart:developer';
import 'dart:io';

import 'package:bladderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/mapper/plan_mapper.dart';
import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/repository/payment_repository.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
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
    final monthlyProductId = Platform.isAndroid ? 'monthly' : 'bladderly.unlimited.monthly';
    final annualProductId = Platform.isAndroid ? 'annual' : 'bladderly.unlimited.annual';

    final planIds = <String>{
      monthlyProductId,
      annualProductId,
    };

    final products = await _inAppPurchase.queryProductDetails(planIds);

    _productDetailsStream.add(products.productDetails);

    return _productDetailsStream.value.map(PlanMapper.fromProdutDetails).toList();
  }

  @override
  Future<void> purchaseOneTimePlan({
    required String userId,
    required String planId,
  }) {
    // TODO: implement purchaseOneTimePlan
    throw UnimplementedError();
  }

  @override
  Future<void> purchaseSubscriptionPlan({
    required String planId,
  }) {
    final productDetails = _productDetailsStream.value.firstWhere((element) => element.id == planId);

    return _inAppPurchase.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: productDetails));
  }

  @override
  Future<PostPayResponse> verifyPayment({
    required String userId,
    required String productId,
    required String purchaseToken,
    required String receipt,
  }) async {
    final result = await _apiClient
        .checkPayment(
      request: PaymentCheckRequest(
        userId: userId,
        device: _deviceInfoModel.os,
        productId: productId,
        purchaseToken: purchaseToken,
        receipt: receipt,
      ),
    )
        .catchError((error) {
      print(error);
      return error;
    });

    return result.body!;
  }
}
