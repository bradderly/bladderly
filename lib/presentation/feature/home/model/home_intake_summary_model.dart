// Package imports:
// Project imports:
import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/num_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeIntakeSummaryModel extends Equatable {
  const HomeIntakeSummaryModel({
    required List<int> volumes,
  }) : _volumes = volumes;

  const HomeIntakeSummaryModel.none() : _volumes = const [];

  factory HomeIntakeSummaryModel.fromDomain(IntakeHistories intakeHistories) {
    return HomeIntakeSummaryModel(volumes: intakeHistories.map((e) => e.recordVolume.toRoundVolume()).toList());
  }

  final List<int> _volumes;

  int getTotalVolume(BuildContext context) {
    return _volumes.map(context.unitValue).fold<int>(0, (a, b) => a + b);
  }

  @override
  List<Object?> get props => [
        _volumes,
      ];
}
