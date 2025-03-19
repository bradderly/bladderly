import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

abstract class PlanMapper {
  const PlanMapper._();

  static Plan fromProdutDetails(ProductDetails productDetails) {
    return Plan(
      product: Product.fromId(productDetails.id),
      name: productDetails is GooglePlayProductDetails ? productDetails.productDetails.name : productDetails.title,
      price: double.tryParse(productDetails.price.replaceAll(RegExp('[^0-9.]'), '')) ?? productDetails.rawPrice,
      originPrice: double.tryParse(productDetails.price.replaceAll(RegExp('[^0-9.]'), '')) ?? productDetails.rawPrice,
      symbol: productDetails.currencySymbol,
    );
  }
}
