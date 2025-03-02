// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/bloc/sign_up_regular_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/cubit/sign_up_regular_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/widget/sign_up_regular_account_info_view.dart';
import 'package:bladderly/presentation/feature/sign_up/widget/sign_up_additional_info_builder.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';

class SignUpRegularView extends StatefulWidget {
  const SignUpRegularView({super.key});

  @override
  State<SignUpRegularView> createState() => _SignUpRegularViewState();
}

class _SignUpRegularViewState extends State<SignUpRegularView> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpRegularBloc, SignUpRegularState>(
      listener: (context, state) => switch (state) {
        SignUpRegularSubmitInProgress() => ProgressIndicatorModal.show(context),
        SignUpRegularSubmitSuccess() => const MainRoute().go(context),
        SignUpRegularSubmitFailure() => context.pop(),
        _ => null,
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 77,
          leading: IconButton(
            onPressed: () {
              final page = pageController.page?.round() ?? 0;
              if (page <= 0) {
                return context.pop();
              }

              pageController.jumpToPage(page - 1);
            },
            icon: Assets.icon.icCommonArrowBack.svg(),
          ),
        ),
        body: SafeArea(
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SignUpRegularAccountInfoView(
                pageController: pageController,
              ),
              SignUpAdditionalInfoBuilder(
                onSubmit: (state) => context.read<SignUpRegularBloc>().add(
                      SignUpRegularSubmit(
                        userId: context.read<UserBloc>().state.userModelOrThrowException.id,
                        email: context.read<SignUpRegularFormCubit>().state.email,
                        password: context.read<SignUpRegularFormCubit>().state.password,
                        userName: state.userName,
                        disease: state.disease,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
