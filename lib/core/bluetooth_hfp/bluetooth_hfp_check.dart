import 'package:flutter/services.dart';

class BluetoothHFPChecker {
  static const MethodChannel _channel = MethodChannel('bluetooth_hfp_checker');

  static Future<bool> isBluetoothHFPConnected() async {
    try {
      final dynamic result = await _channel.invokeMethod('isBluetoothHFPConnected');
      print('Bluetooth HFP: $result');
      return result as bool; // ✅ 명시적 캐스팅 추가
    } on PlatformException catch (e) {
      print('Error checking Bluetooth HFP: ${e.message}');
      return false;
    }
  }
}
