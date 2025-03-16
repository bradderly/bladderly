import 'package:bladderly/domain/exception/already_exist_user_exception.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/util/password_util.dart';
import 'package:bladderly/presentation/common/widget/common_error_modal.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/sign_up/method/bloc/sign_up_method_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/method/cubit/sign_up_method_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/method/widget/sign_up_method_account_info_view.dart';
import 'package:bladderly/presentation/feature/sign_up/method/widget/sign_up_method_widget.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpMethodView extends StatelessWidget {
  const SignUpMethodView({super.key});

  Future<void> _onSelectSuccess(BuildContext context, SignUpMethodSelectSuccess state) async {
    context.pop();

    if (state.email case final String email) {
      return _signUp(
        context,
        signUpMethod: state.method,
        email: email,
        password: PasswordUtil.generatePassword(email),
      );
    }
  }

  Future<void> _onSelectFailure(BuildContext context, SignUpMethodSelectFailure state) async {
    context.pop();

    if (state.exception case final AlreadyExistUserException exception) {
      return CommonErrorModal.showFromDominException<void>(
        context,
        onTap: context.pop,
        exception: exception,
      );
    }
  }

  Future<void> _signUp(
    BuildContext context, {
    required SignUpMethod signUpMethod,
    required String email,
    required String password,
  }) async {
    final isAgreed = await const SignUpConsentRoute().push<bool>(context);

    if (isAgreed == true && context.mounted) {
      final extra = SignUpRegularRouteExtra(signUpMethod: signUpMethod, email: email, password: password);
      return SignUpRegularRoute($extra: extra).push<void>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpMethodBloc, SignUpMethodState>(
      listener: (context, state) => switch (state) {
        SignUpMethodSelectInProgress() => ProgressIndicatorModal.show(context),
        SignUpMethodSelectSuccess() => _onSelectSuccess(context, state),
        SignUpMethodSelectFailure() => _onSelectFailure(context, state),
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
          child: BlocBuilder<SignUpMethodBloc, SignUpMethodState>(
            builder: (context, state) {
              if (state is SignUpMethodSelectSuccess && state.shouldInputAccountInfo) {
                return SignUpMethodAccountInfoView(
                  onContinue: () => _signUp(
                    context,
                    signUpMethod: state.method,
                    email: context.read<SignUpMethodFormCubit>().state.email,
                    password: context.read<SignUpMethodFormCubit>().state.password,
                  ),
                );
              }

              return const SignUpMethodWidget();
            },
          ),
        ),
      ),
    );
  }
}
