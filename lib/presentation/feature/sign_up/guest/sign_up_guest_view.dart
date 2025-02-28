import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_keyboard_actions.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/bloc/signup_guest_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/cubit/sign_up_guest_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/widget/sign_up_guest_field_widget.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/widget/sign_up_guest_header_widget.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignUpGuestView extends StatefulWidget {
  const SignUpGuestView({
    super.key,
    this.email,
    this.signUpMethod,
  });

  final String? email;
  final String? signUpMethod;

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
    const MainRoute().go(context..read<UserBloc>().add(UserLoad()));
  }

  void signup(BuildContext context) {
    final form = context.read<SignUpGuestFormCubit>().state;

    if (!form.isValid) return;

    context.read<SignUpGuestBloc>().add(
          SignupGuestSubmit(
            gender: form.sex!,
            yearOfBirth: form.yearOfBirth,
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              CommonKeyboardActions(
                focusNode: yearOfBirthFocusNode,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 32),
                  physics: const ClampingScrollPhysics(),
                  children: [
                    const SignUpGuestHeaderWidget(),
                    const Gap(64),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SignUpGuestFieldWidget(
                          text: 'Sex'.tr(context),
                          child: BlocSelector<SignUpGuestFormCubit, SignUpGuestFormState, Gender?>(
                            selector: (state) => state.sex,
                            builder: (context, selectedSex) => Row(
                              children: List.generate(
                                Gender.values.length * 2 - 1,
                                (index) {
                                  if (index.isOdd) return const Gap(16);

                                  final sex = Gender.values[index ~/ 2];
                                  final isSelected = sex == selectedSex;

                                  return Expanded(
                                    child: PrimaryButton.outlined(
                                      onPressed: () => context.read<SignUpGuestFormCubit>().setSex(sex),
                                      borderWidth: 3,
                                      borderColor: isSelected
                                          ? context.colorTheme.vermilion.secondary.shade20
                                          : context.colorTheme.neutral.shade3,
                                      backgroundColor: isSelected
                                          ? context.colorTheme.vermilion.secondary.shade10
                                          : context.colorTheme.neutral.shade3,
                                      borderRadius: 100,
                                      shape: BoxShape.rectangle,
                                      text: sex.text.tr(context),
                                      textColor: isSelected
                                          ? context.colorTheme.vermilion.secondary.shade40
                                          : context.colorTheme.neutral.shade6,
                                      size: const Size.fromHeight(43),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const Gap(32),
                        SignUpGuestFieldWidget(
                          text: 'Year of Birth'.tr(context),
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.colorTheme.neutral.shade2,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              onChanged: context.read<SignUpGuestFormCubit>().setYearOfBirth,
                              focusNode: yearOfBirthFocusNode,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
                                isDense: false,
                              ),
                              style:
                                  context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                TextInputFormatter.withFunction((oldValue, newValue) {
                                  final year = int.tryParse(newValue.text);

                                  if (year == null) return newValue;

                                  if (year > DateTime.now().year) return oldValue;

                                  return newValue;
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildGetStartedButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Positioned.fill(
      top: null,
      left: 24,
      right: 24,
      bottom: 28,
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) => isKeyboardVisible
            ? const SizedBox.shrink()
            : BlocSelector<SignUpGuestFormCubit, SignUpGuestFormState, bool>(
                selector: (state) => state.isValid,
                builder: (context, isValid) => PrimaryButton.filled(
                  onPressed: () => signup(context),
                  backgroundColor:
                      isValid ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
                  borderRadius: 400,
                  shape: BoxShape.rectangle,
                  text: 'Get Started'.tr(context),
                  textColor: context.colorTheme.neutral.shade0,
                  size: const Size.fromHeight(56),
                ),
              ),
      ),
    );
  }
}
