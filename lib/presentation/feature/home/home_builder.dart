import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/presentation/feature/home/cubit/home_summary_cubit.dart';
import 'package:bradderly/presentation/feature/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBuilder extends StatelessWidget {
  const HomeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeSummaryCubit(getHistoriesStreamUsecase: getIt())..subscribe(DateTime.now()),
      child: const HomeView(),
    );
  }
}
