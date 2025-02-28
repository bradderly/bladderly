import 'package:bladderly/presentation/common/model/beverage_type_model.dart';
import 'package:equatable/equatable.dart';

class IntakeInputBeverageModel extends Equatable {
  const IntakeInputBeverageModel({
    required this.typeModel,
    required this.typeValue,
  });

  factory IntakeInputBeverageModel.onlyType(BeverageTypeModel typeModel) {
    return IntakeInputBeverageModel(
      typeModel: typeModel,
      typeValue: '',
    );
  }

  final BeverageTypeModel typeModel;
  final String typeValue;

  bool get isValid {
    if (typeModel == BeverageTypeModel.others && typeValue.isEmpty) {
      return false;
    }

    return true;
  }

  IntakeInputBeverageModel copyWith({
    BeverageTypeModel? typeModel,
    String? typeValue,
  }) {
    return IntakeInputBeverageModel(
      typeModel: typeModel ?? this.typeModel,
      typeValue: typeValue ?? this.typeValue,
    );
  }

  String get value {
    return switch (typeModel) {
      BeverageTypeModel.others => typeValue,
      _ => typeModel.name,
    };
  }

  @override
  List<Object?> get props => [
        typeModel,
        typeValue,
      ];
}
