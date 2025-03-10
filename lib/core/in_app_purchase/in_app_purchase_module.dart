import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InAppPurchaseModule {
  @lazySingleton
  @preResolve
  Future<InAppPurchase> get inAppPurchase async {
    if (Platform.isIOS) await InAppPurchaseStoreKitPlatform.enableStoreKit2();
    return InAppPurchase.instance;
  }
}
