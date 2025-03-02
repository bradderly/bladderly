// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/sign_up/social/bloc/sign_up_social_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/widget/sign_up_additional_info_builder.dart';
import 'package:bladderly/presentation/feature/sign_up/widget/sign_up_required_info_builder.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';

class SignUpSocialView extends StatefulWidget {
  const SignUpSocialView({
    super.key,
    required this.signUpMethod,
    required this.email,
  });

  final SignUpMethod signUpMethod;
  final String email;

  @override
  State<SignUpSocialView> createState() => _SignUpSocialViewState();
}

class _SignUpSocialViewState extends State<SignUpSocialView> {
  final yearOfBirthFocusNode = FocusNode(debugLabel: 'yearOfBirthFocusNode');
  final pageController = PageController();

  late Gender gender;
  late int yearOfBirth;
  late String userName;
  late String disease;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpSocialBloc, SignUpSocialState>(
      listener: (context, state) => switch (state) {
        SignUpSocialSubmitInProgress() => ProgressIndicatorModal.show(context),
        SignUpSocialSubmitSuccess() => const MainRoute().go(context),

        // TODO(eden): 소셜 회원가입 실패 처리 필요.
        SignUpSocialSubmitFailure() => context.pop(),
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
              SignUpRequiredInfoBuilder(
                onSubmit: (state) {
                  gender = state.gender!;
                  yearOfBirth = state.yearOfBirth;
                  pageController.jumpToPage(1);
                },
                yearOfBirthFocusNode: yearOfBirthFocusNode,
              ),
              SignUpAdditionalInfoBuilder(
                onSubmit: (state) {
                  userName = state.userName;
                  disease = state.disease;

                  context.read<SignUpSocialBloc>().add(
                        SignUpSocialSubmit(
                          email: widget.email,
                          signUpMethod: widget.signUpMethod,
                          gender: gender,
                          yearOfBirth: yearOfBirth,
                          userName: userName,
                          disease: disease,
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
