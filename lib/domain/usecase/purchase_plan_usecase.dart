import 'package:bladderly/domain/model/product.dart';
import 'package:bladderly/domain/repository/payment_repository.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:injectable/injectable.dart';

@module
abstract class PurchasePlanUsecaseModule {
  @Named('android')
  @lazySingleton
  PurchasePlanUsecase getAndroidPurchasePlan({
    required PaymentRepository paymentRepository,
    required UserRepository userRepository,
    required InAppPurchase inAppPurchase,
  }) {
    return _AndroidPurchasePlanUsecase(
      paymentRepository: paymentRepository,
      userRepository: userRepository,
      inAppPurchase: inAppPurchase,
    );
  }

  @Named('iOS')
  @lazySingleton
  PurchasePlanUsecase getIosPurchasePlan({
    required PaymentRepository paymentRepository,
    required UserRepository userRepository,
  }) {
    return _IosPurchasePlanUsecase(
      paymentRepository: paymentRepository,
      userRepository: userRepository,
      inAppPurchase: InAppPurchase.instance,
    );
  }
}

abstract class PurchasePlanUsecase {
  const PurchasePlanUsecase();

  PaymentRepository get _paymentRepository;

  UserRepository get _userRepository;

  Future<Either<Exception, bool>> call({
    required String userId,
    required String productId,
    String? offerCode,
  }) async {
    try {
      if (productId == Product.threeDaysPass.id) {
        await _purchaseWithoutIap(productId: productId, userId: userId);
      } else {
        await _purchaseWithIap(productId: productId, offerCode: offerCode);
      }

      return const Right(true);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<void> _purchaseWithoutIap({
    required String productId,
    required String userId,
  }) async {
    final localUserId = _userRepository.getLocalUserIdByUserId(userId)!;

    await _paymentRepository.purchaseWithoutIap(productId: productId, userId: userId);

    final membership = await _userRepository.getMembershipFromServer(userId: userId);

    if (membership != null) _userRepository.saveMembership(localUserId: localUserId, membership: membership);
  }

  Future<bool> _purchaseWithIap({required String productId, String? offerCode});
}

class _AndroidPurchasePlanUsecase extends PurchasePlanUsecase {
  _AndroidPurchasePlanUsecase({
    required PaymentRepository paymentRepository,
    required UserRepository userRepository,
    required InAppPurchase inAppPurchase,
  })  : _paymentRepository = paymentRepository,
        _userRepository = userRepository,
        _inAppPurchase = inAppPurchase;

  @override
  final PaymentRepository _paymentRepository;
  @override
  final UserRepository _userRepository;
  final InAppPurchase _inAppPurchase;

  @override
  Future<bool> _purchaseWithIap({
    required String productId,
    String? offerCode,
  }) async {
    final platformAdditional = _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
    final products = await _inAppPurchase
        .queryProductDetails(Product.ids)
        .then((value) => value.productDetails.cast<GooglePlayProductDetails>());

    final productDetails = products.firstWhereOrNull((product) {
      final subscriptionOfferDetails = product.productDetails.subscriptionOfferDetails?[product.subscriptionIndex!];

      return product.id == productId && subscriptionOfferDetails?.offerId == offerCode;
    });

    /// TODO:쿼리에 없는 제품을 구매하려고 할때 대응 필요
    if (productDetails == null) {
      return false;
    }

    final pastPurchase = await platformAdditional.queryPastPurchases().then(
          (response) => response.pastPurchases.firstWhereOrNull(
            (e) => e.billingClientPurchase.isAutoRenewing && e.status == PurchaseStatus.purchased,
          ),
        );

    final currentProduct = Product.values.firstWhereOrNull((product) => product.id == pastPurchase?.productID);
    final newProduct = Product.fromId(productDetails.id);
    final replacementMode = currentProduct?.calculateReplacementModeByNewProduct(newProduct);

    final changeSubscriptionParam = pastPurchase == null
        ? null
        : ChangeSubscriptionParam(oldPurchaseDetails: pastPurchase, replacementMode: replacementMode);

    return _inAppPurchase.buyNonConsumable(
      purchaseParam: GooglePlayPurchaseParam(
        productDetails: productDetails,
        changeSubscriptionParam: changeSubscriptionParam,
      ),
    );
  }
}

class _IosPurchasePlanUsecase extends PurchasePlanUsecase {
  const _IosPurchasePlanUsecase({
    required PaymentRepository paymentRepository,
    required UserRepository userRepository,
    required InAppPurchase inAppPurchase,
  })  : _paymentRepository = paymentRepository,
        _userRepository = userRepository,
        _inAppPurchase = inAppPurchase;

  @override
  final PaymentRepository _paymentRepository;
  @override
  final UserRepository _userRepository;
  final InAppPurchase _inAppPurchase;

  @override
  Future<bool> _purchaseWithIap({required String productId, String? offerCode}) async {
    final productDetails = await _inAppPurchase.queryProductDetails(Product.ids).then(
          (response) => response.productDetails.firstWhereOrNull((product) => product.id == productId),
        );

    if (productDetails == null) {
      return false;
    }

    return _inAppPurchase.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: productDetails));
  }
}
