import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:dartz/dartz.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPaywallPlanUsecase {
  const GetPaywallPlanUsecase({
    required InAppPurchase inAppPurchase,
  }) : _inAppPurchase = inAppPurchase;

  final InAppPurchase _inAppPurchase;

  Future<Either<Exception, Plan>> call({
    required String offerCode,
  }) async {
    try {
      final productDetails = await _inAppPurchase
          .queryProductDetails(Product.ids)
          .then((value) => value.productDetails.cast<GooglePlayProductDetails>())
          .then(
            (value) => value.where((e) => e.subscriptionIndex != null).firstWhere(
                  (e) => e.productDetails.subscriptionOfferDetails?[e.subscriptionIndex!].offerId == offerCode,
                ),
          );

      return Right(
        Plan(
          product: Product.fromId(productDetails.id),
          name: productDetails.productDetails.name,
          priceStr: productDetails.price.replaceAll(RegExp('[^0-9.]'), ''),
          price: double.tryParse(productDetails.price.replaceAll(RegExp('[^0-9.]'), '')) ?? productDetails.rawPrice,
          originPrice:
              double.tryParse(productDetails.price.replaceAll(RegExp('[^0-9.]'), '')) ?? productDetails.rawPrice,
          symbol: productDetails.currencySymbol,
        ),
      );
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
