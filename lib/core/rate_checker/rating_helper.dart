import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/data/local/local_storage_client.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rate_my_app/rate_my_app.dart';

@module
abstract class RatingHelperModule {
  @lazySingleton
  @preResolve
  Future<RatingHelper> getRatingHelper() => RatingHelper._create();
}

class RatingHelper {
  const RatingHelper({
    required RateMyApp rateMyApp,
  }) : _rateMyApp = rateMyApp;

  final RateMyApp _rateMyApp;

  static Future<RatingHelper> _create() {
    final rateMyApp = RateMyApp(minDays: 0, minLaunches: 2, remindDays: 2, remindLaunches: 0);

    return rateMyApp.init().then((_) => RatingHelper(rateMyApp: rateMyApp));
  }

  Future<void> checkAndShowRateDialog(BuildContext context) async {
    final isar = getIt<LocalStorageClient>();
    final rateTrigger = await isar.getRateTrigger();
    rateTrigger.count++;

    var showRate = _rateMyApp.shouldOpenDialog;

    switch (rateTrigger.attemptNumber) {
      case 0:
        if (rateTrigger.count < 3) {
          showRate = false;
        }
      case 1:
        if (rateTrigger.count < 53) {
          showRate = false;
        }
      case 2:
        if (rateTrigger.count < 103) {
          showRate = false;
        }
    }

    if (showRate && context.mounted) {
      await _rateMyApp.showRateDialog(
        context,
        onDismissed: () {
          rateTrigger.attemptNumber++;
        },
      );
    }
    await isar.updateRateTrigger(rateTrigger);
  }
}
