import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rate_my_app/rate_my_app.dart';

@lazySingleton
class RatingHelper {
  void init() {
    _rateMyApp.init();
  }

  static final RateMyApp _rateMyApp = RateMyApp(minDays: 0, minLaunches: 2, remindDays: 2, remindLaunches: 0);

  Future<void> checkAndShowRateDialog(BuildContext context) async {
    final isar = getIt<IsarClient>();
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

    if (showRate) {
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
