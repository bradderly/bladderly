// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/sign_up/cubit/sign_up_required_info_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/bloc/signup_guest_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/widget/sign_up_required_info_builder.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';

class SignUpGuestView extends StatefulWidget {
  const SignUpGuestView({super.key});

  @override
  State<SignUpGuestView> createState() => _SignUpGuestViewState();
}

class _SignUpGuestViewState extends State<SignUpGuestView> {
  final yearOfBirthFocusNode = FocusNode(debugLabel: 'yearOfBirthFocusNode');

  @override
  void dispose() {
    yearOfBirthFocusNode.dispose();
    super.dispose();
  }

  void onSignupSuccess(BuildContext context, SignupGuestSubmitSuccess state) {
    const MainRoute().go(context..read<UserBloc>().add(const UserLoad()));
  }

  void signup(BuildContext context, SignUpRequiredInfoFormState state) {
    if (!state.isValid) return;

    context.read<SignUpGuestBloc>().add(
          SignupGuestSubmit(
            gender: state.gender!,
            yearOfBirth: state.yearOfBirth,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpGuestBloc, SignUpGuestState>(
      listener: (context, state) => switch (state) {
        SignupGuestSubmitInProgress() => ProgressIndicatorModal.show(context),
        SignupGuestSubmitSuccess() => onSignupSuccess(context, state),
        SignupGuestSubmitFailure() => context.pop(),
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
          child: SignUpRequiredInfoBuilder(
            yearOfBirthFocusNode: yearOfBirthFocusNode,
            onSubmit: (state) => signup(context, state),
          ),
        ),
      ),
    );
  }
}
