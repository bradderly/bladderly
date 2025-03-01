// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkCheckerModule {
  @lazySingleton
  NetworkChecker get networkChecker => _NetworkCheckerImpl(connectivity: Connectivity());
}

abstract class NetworkChecker {
  Future<bool> get isConnected;
}

class _NetworkCheckerImpl implements NetworkChecker {
  const _NetworkCheckerImpl({
    required Connectivity connectivity,
  }) : _connectivity = connectivity;

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected => _connectivity
      .checkConnectivity()
      .then((result) => !result.contains(ConnectivityResult.none))
      .catchError((_) => false);
}
