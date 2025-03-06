// Flutter imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/change_user_name_usecase.dart';
import 'package:bladderly/presentation/feature/menu/profile/bloc/profile_bloc.dart';
import 'package:bladderly/presentation/feature/menu/profile/cubit/profile_form_cubit.dart';
import 'package:bladderly/presentation/feature/menu/profile/profile_modal.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBuilder extends StatelessWidget {
  const ProfileBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileFormCubit>(
          create: (_) => ProfileFormCubit(),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(changeUserNameUsecase: getIt<ChangeUserNameUsecase>()),
        ),
      ],
      child: const ProfileModal(),
    );
  }
}
