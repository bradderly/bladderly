import 'dart:io';

import 'package:collection/collection.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';

enum Product {
  threeDaysPass(type: ProductType.nonRenewalSubscription),
  annualSubscription(type: ProductType.renewalSubscription),
  monthlySubscription(type: ProductType.renewalSubscription),
  oneTimeExport(type: ProductType.consumable),
  oneDayFreeTrial(type: ProductType.freeTrial),
  ;

  const Product({required this.type});

  factory Product.fromId(String id) => Product.values.firstWhere((product) => product.id == id);

  static Product? findOneOrNullById(String id) => Product.values.firstWhereOrNull((product) => product.id == id);

  final ProductType type;

  String get id {
    return switch (this) {
      Product.monthlySubscription => Platform.isAndroid ? 'monthly' : 'bladderly.unlimited.monthly',
      Product.annualSubscription => Platform.isAndroid ? 'annual' : 'bladderly.unlimited.annual',
      Product.threeDaysPass => 'threedaypass',
      Product.oneTimeExport => 'onetimeexport',
      Product.oneDayFreeTrial => 'onedayfreetrial',
    };
  }

  static Set<String> get ids => Product.values.map((product) => product.id).toSet();

  ReplacementMode? calculateReplacementModeByNewProduct(Product newProduct) {
    return switch (this) {
      /// monthly upgrade to annual
      monthlySubscription when newProduct == annualSubscription => ReplacementMode.chargeFullPrice,

      /// annual downgrade to monthly
      annualSubscription when newProduct == monthlySubscription => ReplacementMode.deferred,
      _ => null,
    };
  }
}

enum ProductType {
  renewalSubscription,
  nonRenewalSubscription,
  consumable,
  freeTrial,
}
