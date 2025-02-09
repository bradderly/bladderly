import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
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

  int get volume {
    return switch (this) {
      IntakeInputDrinkMoreVolumeModel() => int.parse(value),
      _ => int.parse(typeValue),
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
  }) : super._(type: 'Small', typeValue: '236');

  @override
  SvgGenImage get icon => Assets.icon.icInputDrinkVolumeSmall;
}

final class IntakeInputDrinkMediumVolumeModel extends IntakeInputRecordVolumeModel {
  const IntakeInputDrinkMediumVolumeModel({
    required super.value,
  }) : super._(type: 'Medium', typeValue: '354');

  @override
  SvgGenImage get icon => Assets.icon.icInputDrinkVolumeMedium;
}

final class IntakeInputDrinkLargeVolumeModel extends IntakeInputRecordVolumeModel {
  const IntakeInputDrinkLargeVolumeModel({
    required super.value,
  }) : super._(type: 'Large', typeValue: '473');

  @override
  SvgGenImage get icon => Assets.icon.icInputDrinkVolumeLarge;
}

final class IntakeInputDrinkMoreVolumeModel extends IntakeInputRecordVolumeModel {
  const IntakeInputDrinkMoreVolumeModel({required super.value}) : super._(type: 'More', typeValue: '');

  @override
  SvgGenImage get icon => Assets.icon.icInputDrinkVolumeMore;

  @override
  bool get isValid => int.tryParse(value) != null;
}
