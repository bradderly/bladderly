import 'package:local_auth/local_auth.dart';
import 'package:synchronized/synchronized.dart';

class BioAuth {
  factory BioAuth() => _instance;

  BioAuth._();

  static final _instance = BioAuth._();

  final _lock = Lock();

  Future<bool> canAuthenticate() async {
    final canCheckBiometrics = await LocalAuthentication().canCheckBiometrics.onError((_, __) => false);
    final isDeviceSupported = await LocalAuthentication().isDeviceSupported().onError((_, __) => false);

    return canCheckBiometrics && isDeviceSupported;
  }

  Future<bool> authenticate() {
    return _lock.synchronized(
      () => LocalAuthentication().authenticate(
        /// TODO: 문구 변경 필요
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
      ),
    );
  }
}
