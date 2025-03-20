import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPaywallPlansUsecase {
  const GetPaywallPlansUsecase({
    required InAppPurchase inAppPurchase,
  }) : _inAppPurchase = inAppPurchase;

  final InAppPurchase _inAppPurchase;

  Future<Either<Exception, List<Plan>>> call({
    required List<ProductType> productTypes,
  }) async {
    try {
      final isAailable = await _inAppPurchase.isAvailable();

      if (!isAailable) {
        throw Exception('In app purchase is not available');
      }

      final response = await _inAppPurchase.queryProductDetails(Product.ids);

      final productDetails = switch (defaultTargetPlatform) {
        TargetPlatform.android =>
          response.productDetails.cast<GooglePlayProductDetails>().where((details) => details.rawPrice != 0.0).toList(),
        _ => response.productDetails,
      };

      final plans = productDetails
          .map(_toPlan)
          .where((plan) => productTypes.contains(plan.product.type))
          .sorted((prev, curr) => prev.product.index.compareTo(curr.product.index));

      return Right(plans);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

  Plan _toPlan(ProductDetails productDetails) {
    return Plan(
      product: Product.fromId(productDetails.id),
      name: productDetails is GooglePlayProductDetails ? productDetails.productDetails.name : productDetails.title,
      priceStr: productDetails.price.replaceAll(RegExp('[^0-9.]'), ''),
      price: double.tryParse(productDetails.price.replaceAll(RegExp('[^0-9.]'), '')) ?? productDetails.rawPrice,
      originPrice: double.tryParse(productDetails.price.replaceAll(RegExp('[^0-9.]'), '')) ?? productDetails.rawPrice,
      symbol: productDetails.currencySymbol,
    );
  }
}
