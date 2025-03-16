import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/get_scores_stream_usecase.dart';
import 'package:bladderly/presentation/feature/symptom/scores/cubit/symptom_scores_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SymptomBuilder extends StatelessWidget {
  const SymptomBuilder({
    super.key,
    required this.navigator,
  });

  final Widget navigator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SymptomScoresCubit>(
      create: (_) => SymptomScoresCubit(getScoresStreamUsecase: getIt<GetScoresStreamUsecase>()),
      child: navigator,
    );
  }
}
