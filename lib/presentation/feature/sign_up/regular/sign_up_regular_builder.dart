// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/usecase/check_already_exist_user_usecase.dart';
import 'package:bladderly/domain/usecase/sign_up_regular_usecase.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/bloc/sign_up_regular_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/sign_up_regular_view.dart';
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpRegularBuilder extends StatelessWidget {
  const SignUpRegularBuilder({
    super.key,
    required this.signUpMethod,
    required this.email,
    required this.password,
  });

  final SignUpMethod signUpMethod;
  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpRegularBloc>(
      create: (_) => SignUpRegularBloc(
        signUpEmailUsecase: getIt<SignUpEmailUsecase>(),
        checkAlreadyExistUserUsecase: getIt<CheckAlreadyExistUserUsecase>(),
      ),
      child: SignUpRegularView(
        signUpMethod: signUpMethod,
        email: email,
        password: password,
      ),
    );
  }
}
