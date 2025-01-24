import 'package:bradderly/presentation/feature/main/cubit/main_tab_cubit.dart';
import 'package:bradderly/presentation/feature/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBuilder extends StatelessWidget {
  const MainBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainTabCubit(),
      child: const MainView(),
    );
  }
}
