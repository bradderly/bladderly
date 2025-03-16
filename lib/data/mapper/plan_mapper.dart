import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

abstract class PlanMapper {
  const PlanMapper._();

  static Plan fromProdutDetails(ProductDetails productDetails) {
    return Plan(
      product: Product.fromId(productDetails.id),
      name: productDetails.title,
      price: double.tryParse(productDetails.price.replaceAll(RegExp('[^0-9.]'), '')) ?? productDetails.rawPrice,
      originPrice: double.tryParse(productDetails.price.replaceAll(RegExp('[^0-9.]'), '')) ?? productDetails.rawPrice,
      symbol: productDetails.currencySymbol,
    );
  }
}
