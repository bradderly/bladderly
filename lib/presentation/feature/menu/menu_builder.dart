// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/change_password_usecase.dart';
import 'package:bladderly/presentation/feature/menu/bloc/menu_bloc.dart';
import 'package:bladderly/presentation/feature/menu/menu_view.dart';

class MenuBuilder extends StatelessWidget {
  const MenuBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MenuBloc>(
          create: (_) => MenuBloc(
            chagnePasswordUsecase: getIt<ChangePasswordUsecase>(),
          ),
        ),
      ],
      child: const MenuView(),
    );
  }
}
