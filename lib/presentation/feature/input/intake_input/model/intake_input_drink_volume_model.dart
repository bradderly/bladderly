// Package imports:
// Project imports:
import 'package:bladderly/domain/model/unit.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:equatable/equatable.dart';

sealed class IntakeInputRecordVolumeModel extends Equatable {
  const IntakeInputRecordVolumeModel._({
    required this.type,
    required this.typeValue,
    required this.value,
  });

  factory IntakeInputRecordVolumeModel.fromVolume(int volume) {
    return values.firstWhere(
      (element) => element.typeValue == '$volume',
      orElse: () => IntakeInputDrinkMoreVolumeModel(value: '$volume'),
    );
  }

  static final values = [
    const IntakeInputDrinkSmallVolumeModel(value: ''),
    const IntakeInputDrinkMediumVolumeModel(value: ''),
    const IntakeInputDrinkLargeVolumeModel(value: ''),
    const IntakeInputDrinkMoreVolumeModel(value: ''),
  ];

  final String type;
  final String typeValue;
  final String value;

  bool get isValid => true;

  SvgGenImage get icon;

  IntakeInputRecordVolumeModel copyWith({
    required String? value,
  }) {
    return switch (this) {
      final IntakeInputDrinkSmallVolumeModel model => IntakeInputDrinkSmallVolumeModel(value: value ?? model.value),
      final IntakeInputDrinkMediumVolumeModel model => IntakeInputDrinkMediumVolumeModel(value: value ?? model.value),
      final IntakeInputDrinkLargeVolumeModel model => IntakeInputDrinkLargeVolumeModel(value: value ?? model.value),
      final IntakeInputDrinkMoreVolumeModel model => IntakeInputDrinkMoreVolumeModel(value: value ?? model.value),
    };
  }

  int getVolume(Unit unit) {
    return switch (this) {
      IntakeInputDrinkMoreVolumeModel() => unit.parseToMl(int.tryParse(value) ?? 0),
      _ => int.tryParse(typeValue) ?? 0,
    };
  }

  @override
  List<Object> get props => [
        type,
        typeValue,
        value,
      ];
}

final class IntakeInputDrinkSmallVolumeModel extends IntakeInputRecordVolumeModel {
  const IntakeInputDrinkSmallVolumeModel({
    required super.value,
  }) : super._(type: 'Small', typeValue: '240');

  @override
  SvgGenImage get icon => Assets.icon.icInputDrinkVolumeSmall;
}

final class IntakeInputDrinkMediumVolumeModel extends IntakeInputRecordVolumeModel {
  const IntakeInputDrinkMediumVolumeModel({
    required super.value,
  }) : super._(type: 'Medium', typeValue: '360');

  @override
  SvgGenImage get icon => Assets.icon.icInputDrinkVolumeMedium;
}

final class IntakeInputDrinkLargeVolumeModel extends IntakeInputRecordVolumeModel {
  const IntakeInputDrinkLargeVolumeModel({
    required super.value,
  }) : super._(type: 'Large', typeValue: '480');

  @override
  SvgGenImage get icon => Assets.icon.icInputDrinkVolumeLarge;
}

final class IntakeInputDrinkMoreVolumeModel extends IntakeInputRecordVolumeModel {
  const IntakeInputDrinkMoreVolumeModel({required super.value}) : super._(type: 'More', typeValue: '');

  @override
  SvgGenImage get icon => Assets.icon.icInputDrinkVolumeMore;

  @override
  bool get isValid => int.tryParse(value) != null || value.isEmpty;
}
