// Package imports:
import 'package:bladderly/domain/exception/domain_exception.dart';
import 'package:bladderly/domain/exception/network_not_connected_exception.dart';
import 'package:bladderly/presentation/common/widget/common_message_modal.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkCheckerModule {
  @lazySingleton
  NetworkChecker get networkChecker => _NetworkCheckerImpl(connectivity: Connectivity());
}

abstract class NetworkChecker {
  Future<bool> get isConnected;
  Future<void> showNetworkAlert(BuildContext context, [DomainException exception]);
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

  @override
  Future<void> showNetworkAlert(BuildContext context,
      [DomainException exception = const NetworkNotConnectedException()]) {
    return CommonMessageModal.showFromDominException<void>(
      context,
      onTap: context.pop,
      exception: exception,
    );
  }
}
