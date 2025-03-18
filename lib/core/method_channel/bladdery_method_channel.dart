import 'dart:io';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BladderyMethodChannel {
  const BladderyMethodChannel();

  static const _methodChannel = MethodChannel('bladderly');

  Future<bool> checkLiveListen() async {
    if (Platform.isAndroid) return false;

    final isLiveListen = await _methodChannel.invokeMethod('checkLiveListen');

    return isLiveListen as bool;
  }
}
