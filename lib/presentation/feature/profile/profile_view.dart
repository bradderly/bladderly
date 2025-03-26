// Project imports:
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/feature/menu/widget/text_icon_arrow_form.dart';
import 'package:bladderly/presentation/feature/profile/bloc/profile_bloc.dart';
import 'package:bladderly/presentation/feature/profile/modal/sign_out_modal.dart';
import 'package:bladderly/presentation/feature/profile/widget/profile_name_input_field.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/profile_route.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// Package imports:

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (prev, curr) => curr is UserLoadSuccess,
      builder: (context, state) {
        final userModel = state.userModelOrThrowException;

        final emailOrId = userModel is RegularUserModel ? userModel.email : userModel.id;
        final nameText = switch (userModel) {
          RegularUserModel() when userModel.name.isNotEmpty => userModel.name,
          _ => 'Bladderly User'.tr(context),
        };

        return Scaffold(
          appBar: ModalAppBar(title: 'User Profile'.tr(context)),
          body: SafeArea(
            child: ListView(
              controller: ModalScrollController.of(context),
              physics: const ClampingScrollPhysics(),
              children: [
                if (userModel is! RegularUserModel)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    margin: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F8F7),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF4F2EC).withValues(alpha: 0.08),
                          offset: const Offset(0, 2),
                          blurRadius: 5,
                        ),
                        BoxShadow(
                          color: const Color(0xFF615737).withValues(alpha: 0.09),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.save_outlined,
                              color: context.colorTheme.vermilion.primary.shade50,
                            ),
                            Text(
                              'Save your data?'.tr(context),
                              style: context.textStyleTheme.b16SemiBold
                                  .copyWith(color: context.colorTheme.neutral.shade10),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => const SignUpMethodRoute().push<void>(context),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 17,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorTheme.vermilion.primary.shade50,
                              borderRadius: BorderRadius.circular(400),
                            ),
                            child: Text(
                              'Create an Account'.tr(context),
                              textAlign: TextAlign.center,
                              style:
                                  context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    'Personal Information'.tr(context),
                    style: context.textStyleTheme.b20Medium.copyWith(color: context.colorTheme.neutral.shade10),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bladderly ID'.tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(
                          color: context.colorTheme.neutral.shade6,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        emailOrId,
                        style: context.textStyleTheme.b16Medium.copyWith(
                          color: context.colorTheme.neutral.shade10,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sex'.tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(
                          color: context.colorTheme.neutral.shade6,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        userModel.gender.text,
                        style: context.textStyleTheme.b16Medium.copyWith(
                          color: context.colorTheme.neutral.shade10,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.userModel?.yearOfBirth != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Year of Birth'.tr(context),
                          style: context.textStyleTheme.b14Medium.copyWith(
                            color: context.colorTheme.neutral.shade6,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          userModel.yearOfBirth.toString(),
                          style: context.textStyleTheme.b16Medium.copyWith(
                            color: context.colorTheme.neutral.shade10,
                          ),
                        ),
                      ],
                    ),
                  ),
                const Gap(8),
                ProfileNameInputField(
                  onSubmit: (name) =>
                      context.read<ProfileBloc>().add(ProfileChangeName(userId: userModel.id, userName: name)),
                  value: nameText,
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    'Manage Account'.tr(context),
                    style: context.textStyleTheme.b20Medium.copyWith(color: context.colorTheme.neutral.shade10),
                  ),
                ),
                const SizedBox(height: 20),
                TextIconArrowForm(
                  onTap: () => const PasscodeRoute().go(context),
                  title: 'Set Up Passcode'.tr(context),
                  icon: Icons.lock,
                ),
                if (userModel.signUpMethod == SignUpMethod.E)
                  TextIconArrowForm(
                    onTap: () => const ChangePasswordRoute().go(context),
                    title: 'Change Password'.tr(context),
                    icon: Icons.lock_open,
                  ),
                if (userModel is RegularUserModel)
                  TextIconArrowForm(
                    onTap: () => SignOutModal.show(context),
                    title: 'Sign Out'.tr(context),
                    icon: Icons.logout,
                  ),
                TextIconArrowForm(
                  onTap: () => const DeleteAccountRoute().go(context),
                  title: userModel is GuestUserModel ? 'Delete All Data'.tr(context) : 'Delete Account'.tr(context),
                  icon: Icons.delete_outline,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}
