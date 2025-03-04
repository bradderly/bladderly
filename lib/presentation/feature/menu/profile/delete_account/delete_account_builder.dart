// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/delete_account_usecase.dart';
import 'package:bladderly/domain/usecase/get_user_stream_usecase.dart';
import 'package:bladderly/domain/usecase/get_user_usecase.dart';
import 'package:bladderly/domain/usecase/sign_out_usecase.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/feature/menu/profile/delete_account/bloc/delete_account_bloc.dart';
import 'package:bladderly/presentation/feature/menu/profile/delete_account/delete_account_modal.dart';

class DeleteAccountBuilder extends StatelessWidget {
  const DeleteAccountBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeleteAccountBloc>(
          create: (_) => DeleteAccountBloc(
            deleteAccountUsecase: getIt<DeleteAccountUsecase>(),
          ),
        ),
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(
            getUserUsecase: getIt<GetUserUsecase>(),
            getUserStreamUsecase: getIt<GetUserStreamUsecase>(),
            signOutUsecase: getIt<SignOutUsecase>(),
          )..add(const UserLoad()),
        ),
      ],
      child: const DeleteAccountModal(),
    );
  }
}
