// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/feature/menu/cubit/menu_cubit.dart';
import 'package:bladderly/presentation/feature/menu/menu_view.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBuilder extends StatelessWidget {
  const MenuBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MenuFormCubit>(
          create: (_) => MenuFormCubit(),
        ),
      ],
      child: const MenuView(),
    );
  }
}
