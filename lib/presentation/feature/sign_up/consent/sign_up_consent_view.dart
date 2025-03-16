import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/feature/sign_up/consent/cubit/sign_up_consent_form_cubit.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/about_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignUpConsentView extends StatelessWidget {
  const SignUpConsentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(
        backButton: true,
        toolbarHeight: 62,
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                Text(
                  'Consent to Personal Data Processing and Usage'.tr(context),
                  style: context.textStyleTheme.b24Bold.copyWith(
                    color: context.colorTheme.neutral.shade10,
                  ),
                ),
                const Gap(20),
                Text(
                  'Consent to Personal Data Processing and Usage body'.tr(context),
                  style: context.textStyleTheme.b12Medium.copyWith(
                    color: context.colorTheme.neutral.shade10,
                  ),
                ),
                const Gap(16),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => const PrivacyRoute().push<void>(context),
                        child: Text(
                          'Privacy Policy'.tr(context),
                          style: context.textStyleTheme.b12SemiBold.copyWith(
                            color: context.colorTheme.vermilion.primary.shade50,
                          ),
                        ),
                      ),
                      const Gap(16),
                      GestureDetector(
                        onTap: () => const TermsRoute().push<void>(context),
                        child: Text(
                          'Terms of Use'.tr(context),
                          style: context.textStyleTheme.b12SemiBold.copyWith(
                            color: context.colorTheme.vermilion.primary.shade50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                BlocSelector<SignUpConsentFormCubit, SignUpConsentFormState, bool>(
                  selector: (state) => state.agreedToTermAndPrivacyPolicy,
                  builder: (context, isSelected) => _buildItem(
                    context,
                    onTap: () => context.read<SignUpConsentFormCubit>().setAgreedToTermAndPrivacyPolicy(!isSelected),
                    isSelected: isSelected,
                    title: 'Terms of Use & Privacy Policy Agreement'.tr(context),
                    body: 'Terms of Use & Privacy Policy Agreement body'.tr(context),
                  ),
                ),
                const Gap(8),
                BlocSelector<SignUpConsentFormCubit, SignUpConsentFormState, bool>(
                  selector: (state) => state.agreedToPersonalDataCollectionAndProcessing,
                  builder: (context, isSelected) => _buildItem(
                    context,
                    onTap: () => context
                        .read<SignUpConsentFormCubit>()
                        .setAgreedToPersonalDataCollectionAndProcessing(!isSelected),
                    isSelected: isSelected,
                    title: 'Consent to Personal Data Collection & Processing'.tr(context),
                    body: 'Consent to Personal Data Collection & Processing body'.tr(context),
                  ),
                ),
                const Gap(8),
                BlocSelector<SignUpConsentFormCubit, SignUpConsentFormState, bool>(
                  selector: (state) => state.agreedToDataTransferAndStorageOutside,
                  builder: (context, isSelected) => _buildItem(
                    context,
                    onTap: () =>
                        context.read<SignUpConsentFormCubit>().setAgreedToDataTransferAndStorageOutside(!isSelected),
                    isSelected: isSelected,
                    title: 'Consent to Data Transfer & Storage Outside Your Country'.tr(context),
                    body: 'Consent to Data Transfer & Storage Outside Your Country body'.tr(context),
                  ),
                ),
                const Gap(180),
              ],
            ),
            Positioned.fill(
              top: null,
              left: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.only(top: 74),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.50, 0),
                    end: const Alignment(0.50, 0.29),
                    colors: [
                      context.colorTheme.neutral.shade0.withValues(alpha: 0),
                      context.colorTheme.neutral.shade0,
                    ],
                  ),
                ),
                child: BlocSelector<SignUpConsentFormCubit, SignUpConsentFormState, bool>(
                  selector: (state) => state.isValid,
                  builder: (context, isValid) => Column(
                    children: [
                      Text(
                        'You cannot create the account without consent.'.tr(context),
                        style: context.textStyleTheme.b12SemiBold.copyWith(
                          color: context.colorTheme.warning,
                        ),
                      ),
                      const Gap(8),
                      PrimaryButton.filled(
                        onPressed: isValid ? () => context.pop(true) : null,
                        backgroundColor:
                            isValid ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade2,
                        borderRadius: 400,
                        shape: BoxShape.rectangle,
                        text: 'Yes, Delete the record'.tr(context),
                        textColor: isValid ? context.colorTheme.neutral.shade0 : context.colorTheme.neutral.shade10,
                        size: const Size.fromHeight(56),
                      ),
                      const Gap(28),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required VoidCallback onTap,
    required bool isSelected,
    required String title,
    required String body,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorTheme.neutral.shade4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: context.textStyleTheme.b14SemiBold.copyWith(
                      color: context.colorTheme.neutral.shade10,
                    ),
                  ),
                ),
                const Gap(12),
                Assets.icon.icSignUpConsentCheck.svg(
                  colorFilter: isSelected
                      ? ColorFilter.mode(context.colorTheme.vermilion.primary.shade50, BlendMode.srcIn)
                      : null,
                ),
              ],
            ),
            const Gap(6),
            Text(
              body,
              style: context.textStyleTheme.b12Medium.copyWith(
                color: context.colorTheme.neutral.shade7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
