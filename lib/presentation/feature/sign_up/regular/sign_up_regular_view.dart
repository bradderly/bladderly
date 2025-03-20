// Flutter imports:

// Project imports:
import 'package:bladderly/domain/exception/already_exist_user_exception.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/widget/common_message_modal.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/bloc/sign_up_regular_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/widget/sign_up_additional_info_builder.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpRegularView extends StatefulWidget {
  const SignUpRegularView({
    super.key,
    required this.signUpMethod,
    required this.email,
    required this.password,
  });

  final SignUpMethod signUpMethod;
  final String email;
  final String password;

  @override
  State<SignUpRegularView> createState() => _SignUpRegularViewState();
}

class _SignUpRegularViewState extends State<SignUpRegularView> {
  Future<void> _checkDuplicateEmailSuccess(BuildContext context, SignUpRegularCheckDuplicateEmailSuccess state) async {}

  Future<void> _checkDuplicateEmailFailure(BuildContext context, SignUpRegularCheckDuplicateEmailFailure state) async {
    context.pop();

    if (state.exception case final AlreadyExistUserException exception) {
      return CommonMessageModal.showFromDominException<void>(
        context,
        onTap: context.pop,
        exception: exception,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpRegularBloc, SignUpRegularState>(
      listener: (context, state) => switch (state) {
        SignUpRegularCheckDuplicateEmailInProgress() => ProgressIndicatorModal.show(context),
        SignUpRegularCheckDuplicateEmailSuccess() => _checkDuplicateEmailSuccess(context, state),
        SignUpRegularCheckDuplicateEmailFailure() => _checkDuplicateEmailFailure(context, state),
        SignUpRegularSubmitInProgress() => ProgressIndicatorModal.show(context),
        SignUpRegularSubmitSuccess() => const MainRoute().go(context),
        SignUpRegularSubmitFailure() => context.pop(),
        _ => null,
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 77,
          leading: IconButton(
            onPressed: context.pop,
            icon: Assets.icon.icCommonArrowBack.svg(),
          ),
        ),
        body: SafeArea(
          child: SignUpAdditionalInfoBuilder(
            onSubmit: (state) => context.read<SignUpRegularBloc>().add(
                  SignUpRegularSubmit(
                    signUpMethod: widget.signUpMethod,
                    userId: context.read<UserBloc>().state.userModelOrThrowException.id,
                    email: widget.email,
                    password: widget.password,
                    userName: state.userName,
                    disease: state.disease,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
