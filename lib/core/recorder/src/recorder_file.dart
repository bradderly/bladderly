import 'package:equatable/equatable.dart';

class RecorderFile extends Equatable {
  const RecorderFile({required this.name});

  /// $userId-$recordDate-$recordTime-$deviceName-$packageVersion-$gender-$diary-null.m4a
  final String name;

  DateTime get recordTime {
    final dt = name.split('-').sublist(1, 3).join();
    final year = int.parse(dt.substring(0, 4));
    final month = int.parse(dt.substring(4, 6));
    final day = int.parse(dt.substring(6, 8));
    final hour = int.parse(dt.substring(8, 10));
    final minute = int.parse(dt.substring(10, 12));
    final second = int.parse(dt.substring(12, 14));

    return DateTime(year, month, day, hour, minute, second);
  }

  @override
  List<Object?> get props => [
        name,
      ];
}
