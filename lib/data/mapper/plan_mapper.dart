import 'package:bladderly/domain/model/plan.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

abstract class PlanMapper {
  const PlanMapper._();

  static Plan fromProdutDetails(ProductDetails productDetails) {
    return Plan(
      id: productDetails.id,
      name: productDetails.title,
      price: productDetails.rawPrice,
      originPrice: productDetails.rawPrice,
      symbol: productDetails.currencySymbol,
    );
  }
}
