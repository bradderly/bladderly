import 'package:equatable/equatable.dart';

class DeviceInfoModel extends Equatable {
  const DeviceInfoModel({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [
        name,
      ];
}
