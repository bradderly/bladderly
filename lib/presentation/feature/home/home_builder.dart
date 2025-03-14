// Flutter imports:

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/presentation/feature/home/cubit/home_cubit.dart';
import 'package:bladderly/presentation/feature/home/cubit/home_summary_cubit.dart';
import 'package:bladderly/presentation/feature/home/home_view.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBuilder extends StatelessWidget {
  const HomeBuilder({
    super.key,
    required this.onPressedMoreVoiding,
    required this.onPressedMoreIntake,
  });

  final VoidCallback onPressedMoreVoiding;
  final VoidCallback onPressedMoreIntake;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeSummaryCubit>(
          create: (_) => HomeSummaryCubit(getHistoriesStreamUsecase: getIt())..subscribe(DateTime.now()),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        ),
      ],
      child: HomeView(
        recorder: getIt<Recorder>(),
        onPressedMoreVoiding: onPressedMoreVoiding,
        onPressedMoreIntake: onPressedMoreIntake,
      ),
    );
  }
}
