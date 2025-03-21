import 'dart:io';

import 'package:collection/collection.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';

/// TODO: 서버에서 받아오는 offer code에 따라 product를 결정하는 로직이 필요함
enum Product {
  threeDaysPass(type: ProductType.nonRenewalSubscription, offerCodes: []),
  annualSubscription(type: ProductType.renewalSubscription, offerCodes: []),
  monthlySubscription(type: ProductType.renewalSubscription, offerCodes: ['one-month-free']),
  oneTimeExport(type: ProductType.consumable, offerCodes: []),
  oneDayFreeTrial(type: ProductType.freeTrial, offerCodes: []),
  ;

  const Product({required this.type, required this.offerCodes});

  factory Product.fromId(String id) => Product.values.firstWhere((product) => product.id == id);

  static Product? fromOfferCode(String offerCode) =>
      Product.values.firstWhereOrNull((product) => product.offerCodes.contains(offerCode));

  final ProductType type;
  final List<String> offerCodes;

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
