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
      return context.read<SignUpMethodBloc>().add(SignUpMethodCheckDuplicateEmail(email: email, method: state.method));
    }
  }

  Future<void> _onSelectFailure(BuildContext context, SignUpMethodSelectFailure state) async {
    context.pop();
  }

  Future<void> _onCheckDuplicateEmailSuccess(
    BuildContext context,
    SignUpMethodCheckDuplicateEmailSuccess state,
  ) async {
    context.pop();

    final formState = context.read<SignUpMethodFormCubit>().state;

    final isAgreed = await const SignUpConsentRoute().push<bool>(context);

    if (isAgreed == true && context.mounted) {
      final extra = SignUpRegularRouteExtra(
        signUpMethod: state.method,
        email: state.email,
        password: state.method == SignUpMethod.E ? formState.password : PasswordUtil.generatePassword(state.email),
      );
      return SignUpRegularRoute($extra: extra).push<void>(context);
    }
  }

  Future<void> _onCheckDuplicateEmailFailure(BuildContext context, SignUpMethodCheckDuplicateEmailFailure state) async {
    context.pop();

    if (state.exception case final AlreadyExistUserException exception) {
      return CommonErrorModal.showFromDominException<void>(
        context,
        onTap: context.pop,
        exception: exception,
      );
    }
  }

  void selectMethod(
    BuildContext context, {
    required SignUpMethod method,
  }) {
    context.read<SignUpMethodBloc>().add(SignUpMethodSelect(method));
  }

  void checkDuplicateEmail(
    BuildContext context, {
    required SignUpMethod method,
  }) {
    final email = context.read<SignUpMethodFormCubit>().state.email;
    context.read<SignUpMethodBloc>().add(SignUpMethodCheckDuplicateEmail(email: email, method: method));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpMethodBloc, SignUpMethodState>(
      listener: (context, state) => switch (state) {
        SignUpMethodSelectInProgress() => ProgressIndicatorModal.show(context),
        SignUpMethodSelectSuccess() => _onSelectSuccess(context, state),
        SignUpMethodSelectFailure() => _onSelectFailure(context, state),
        SignUpMethodCheckDuplicateEmailInProgress() => ProgressIndicatorModal.show(context),
        SignUpMethodCheckDuplicateEmailSuccess() => _onCheckDuplicateEmailSuccess(context, state),
        SignUpMethodCheckDuplicateEmailFailure() => _onCheckDuplicateEmailFailure(context, state),
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
            builder: (context, state) => switch (state) {
              SignUpMethodInitial() => SignUpMethodWidget(
                  onSignUp: (method) => selectMethod(context, method: method),
                ),
              SignUpMethodSelectInProgress() => SignUpMethodWidget(
                  onSignUp: (method) => selectMethod(context, method: method),
                ),
              SignUpMethodSelectSuccess() => SignUpMethodAccountInfoView(
                  onContinue: () => checkDuplicateEmail(context, method: state.method),
                ),
              SignUpMethodSelectFailure() => SignUpMethodWidget(
                  onSignUp: (method) => selectMethod(context, method: method),
                ),
              SignUpMethodCheckDuplicateEmailInProgress() => SignUpMethodAccountInfoView(
                  onContinue: () => checkDuplicateEmail(context, method: state.method),
                ),
              SignUpMethodCheckDuplicateEmailSuccess() => SignUpMethodAccountInfoView(
                  onContinue: () => checkDuplicateEmail(context, method: state.method),
                ),
              SignUpMethodCheckDuplicateEmailFailure() => SignUpMethodAccountInfoView(
                  onContinue: () => checkDuplicateEmail(context, method: state.method),
                ),
            },
          ),
        ),
      ),
    );
  }
}
