import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/feature/menu/bloc/menu_bloc.dart';
import 'package:bladderly/presentation/feature/menu/profile/change_password/change_password_builder.dart';
import 'package:bladderly/presentation/feature/menu/profile/change_password/change_password_modal.dart';
import 'package:bladderly/presentation/feature/menu/profile/delete_account_modal.dart';
import 'package:bladderly/presentation/feature/menu/profile/setup_passcode_modal.dart';
import 'package:bladderly/presentation/feature/menu/utils/modal_helper.dart';
import 'package:bladderly/presentation/feature/menu/widget/input_text_form.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bladderly/presentation/feature/menu/widget/text_icon_arrow_form.dart';
import 'package:bladderly/presentation/feature/menu/widget/text_view_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileModal extends StatelessWidget {
  const UserProfileModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 41),
          child: Column(
            children: [
              ModalTitle(context, 'User Profile'.tr(context)),
              const SizedBox(height: 41),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        'Personal Information'.tr(context),
                        style: context.textStyleTheme.b20Medium.copyWith(color: context.colorTheme.neutral.shade10),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextViewForm('Email ID'.tr(context), '9xq8wcb4xq@privaterelay.appleid.com', context),
                    TextViewForm('Sex'.tr(context), 'Female', context),
                    TextViewForm('Year of Birth'.tr(context), '2000', context),
                    InputTextForm('Preferred Name'.tr(context), 'Mila', context),
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
                      onTap: () {
                        // ignore: inference_failure_on_function_invocation
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return const SetupPasscodeModal();
                          },
                        );
                      },
                    ),
                    TextIconArrowForm(
                      title: 'Change Password'.tr(context),
                      icon: Icons.lock_open,
                      onTap: () {
                        ModalHelper.showModal(
                          context: context,
                          modalContent: const ChangePasswordBuilder(),
                          duration: 5,
                        );
                      },
                    ),
                    TextIconArrowForm(
                      title: 'Sign out'.tr(context),
                      icon: Icons.logout,
                      onTap: () {
                        // ignore: inference_failure_on_function_invocation
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
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
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
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
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
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
                            );
                          },
                        );
                      },
                    ),
                    TextIconArrowForm(
                      title: 'Delete Account'.tr(context),
                      icon: Icons.delete_outline,
                      onTap: () {
                        // ignore: inference_failure_on_function_invocation
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return const DeleteAccountModal();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
