import 'package:equatable/equatable.dart';

class DeviceInfoModel extends Equatable {
  const DeviceInfoModel({
    required this.name,
    required this.region,
  });

  final String name;
  final String region;

  @override
  List<Object?> get props => [
        name,
        region,
      ];
}
