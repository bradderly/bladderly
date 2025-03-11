// Package imports:
import 'package:equatable/equatable.dart';

class DeviceInfoModel extends Equatable {
  const DeviceInfoModel({required this.name, required this.region, required this.os});

  final String name;
  final String region;
  final String os;

  @override
  List<Object?> get props => [
        name,
        region,
        os,
      ];
}
