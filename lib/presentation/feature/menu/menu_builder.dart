// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/presentation/feature/menu/cubit/menu_cubit.dart';
import 'package:bladderly/presentation/feature/menu/menu_view.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBuilder extends StatelessWidget {
  const MenuBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final networkChecker = getIt<NetworkChecker>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<MenuFormCubit>(
          create: (_) => MenuFormCubit(),
        ),
      ],
      child: MenuView(
        networkChecker: networkChecker,
      ),
    );
  }
}
