// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/usecase/sign_up_social_usecase.dart';
import 'package:bladderly/presentation/feature/sign_up/social/bloc/sign_up_social_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/social/sign_up_social_view.dart';

class SignUpSocialBuilder extends StatelessWidget {
  const SignUpSocialBuilder({
    super.key,
    required this.email,
    required this.signUpMethod,
  });

  final String email;
  final String signUpMethod;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpSocialBloc>(
      create: (_) => SignUpSocialBloc(signUpSocialUsecase: getIt<SignUpSocialUsecase>()),
      child: SignUpSocialView(
        email: email,
        signUpMethod: SignUpMethod.of(signUpMethod),
      ),
    );
  }
}
