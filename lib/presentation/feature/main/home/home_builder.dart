import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/presentation/feature/main/home/cubit/home_summary_cubit.dart';
import 'package:bradderly/presentation/feature/main/home/home_view.dart';
import 'package:flutter/material.dart';
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
    return BlocProvider<HomeSummaryCubit>(
      create: (_) => HomeSummaryCubit(getHistoriesStreamUsecase: getIt())..subscribe(DateTime.now()),
      child: HomeView(
        onPressedMoreVoiding: onPressedMoreVoiding,
        onPressedMoreIntake: onPressedMoreIntake,
      ),
    );
  }
}
