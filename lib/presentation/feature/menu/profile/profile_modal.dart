// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/feature/menu/profile/bloc/profile_bloc.dart';
import 'package:bladderly/presentation/feature/menu/profile/change_password/change_password_builder.dart';
import 'package:bladderly/presentation/feature/menu/profile/delete_account/delete_account_builder.dart';
import 'package:bladderly/presentation/feature/menu/profile/passcode/password_builder.dart';
import 'package:bladderly/presentation/feature/menu/profile/widget/profile_name_input_field.dart';
import 'package:bladderly/presentation/feature/menu/utils/modal_helper.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bladderly/presentation/feature/menu/widget/text_icon_arrow_form.dart';
import 'package:bladderly/presentation/feature/menu/widget/text_view_form.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// Package imports:

class ProfileModal extends StatelessWidget {
  const ProfileModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: BlocBuilder<UserBloc, UserState>(
          buildWhen: (prev, curr) => curr is UserLoadSuccess,
          builder: (context, state) {
            final userModel = state.userModelOrThrowException;

            final emailOrId = userModel is RegularUserModel ? userModel.email : userModel.id;
            final nameText = switch (userModel) {
              RegularUserModel() when userModel.name.isNotEmpty => userModel.name,
              _ => 'Bladderly User'.tr(context),
            };

            return Column(
              children: [
                const Gap(40),
                ModalTitle(context, 'User Profile'.tr(context)),
                const SizedBox(height: 41),
                Expanded(
                  child: ListView(
                    controller: controller,
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
                                onTap: () => const SignUpRegularRoute().go(context),
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
                                    'Create an Account or Sign In'.tr(context),
                                    textAlign: TextAlign.center,
                                    style: context.textStyleTheme.b16SemiBold
                                        .copyWith(color: context.colorTheme.neutral.shade0),
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
                      TextViewForm(
                        'Email ID'.tr(context),
                        emailOrId,
                        context,
                      ),
                      TextViewForm(
                        'Sex'.tr(context),
                        userModel.gender.text,
                        context,
                      ),
                      TextViewForm(
                        'Year of Birth'.tr(context),
                        userModel.yearOfBirth.toString(),
                        context,
                      ),
                      const Gap(8),
                      ProfileNameInputField(
                        onSubmit: (name) => context.read<ProfileBloc>().add(
                              ProfileChangeName(
                                userId: userModel.id,
                                userName: name,
                              ),
                            ),
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
                        title: 'Set Up Passcode'.tr(context),
                        icon: Icons.lock,
                        onTap: () => showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const PasscodeBuilder(),
                        ),
                      ),
                      TextIconArrowForm(
                        title: 'Change Password'.tr(context),
                        icon: Icons.lock_open,
                        onTap: () => ModalHelper.showModal(
                          context: context,
                          modalContent: const ChangePasswordBuilder(),
                          duration: 5,
                        ),
                      ),
                      TextIconArrowForm(
                        title: 'Sign out'.tr(context),
                        icon: Icons.logout,
                        onTap: () => showDialog<void>(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: context.colorTheme.neutral.shade0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              height: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    child: Text(
                                      'Sign out Message'.tr(context),
                                      style: context.textStyleTheme.b16SemiBold
                                          .copyWith(color: context.colorTheme.neutral.shade10),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  GestureDetector(
                                    onTap: () => context.read<UserBloc>().add(const UserSignOut()),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: context.colorTheme.neutral.shade2,
                                        borderRadius: BorderRadius.circular(400),
                                      ),
                                      child: Text(
                                        'Yes, Sign Out'.tr(context),
                                        style: context.textStyleTheme.b16SemiBold
                                            .copyWith(color: context.colorTheme.neutral.shade10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  GestureDetector(
                                    onTap: Navigator.of(context).pop,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: context.colorTheme.vermilion.primary.shade50,
                                        borderRadius: BorderRadius.circular(400),
                                      ),
                                      child: Text(
                                        'No, Keep Me Signed In'.tr(context),
                                        style: context.textStyleTheme.b16SemiBold
                                            .copyWith(color: context.colorTheme.neutral.shade0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextIconArrowForm(
                        title: 'Delete Account'.tr(context),
                        icon: Icons.delete_outline,
                        onTap: () => ModalHelper.showModal(
                          context: context,
                          modalContent: const DeleteAccountBuilder(),
                          duration: 5,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
