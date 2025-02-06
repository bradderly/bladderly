import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/widget/input_text_form.dart';
import 'package:bradderly/presentation/feature/menu/widget/text_arrow.dart';
import 'package:bradderly/presentation/feature/menu/profile/change_password_modal.dart';
import 'package:bradderly/presentation/feature/menu/profile/delete_account_modal.dart';
import 'package:bradderly/presentation/feature/menu/profile/setup_passcode_modal.dart';
import 'package:bradderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';

class UserProfileModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric( vertical: 41),
          child: ListView(
            controller: controller,
            children: [

                    ModalTitle(context, 'User Profile'.tr(context)),
              const SizedBox(height: 41),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  'Personal Detail'.tr(context),
                  style: context.textStyleTheme.b20Medium.copyWith(
                      color: context.colorTheme.neutral.shade10),
                ),
              ),
              const SizedBox(height: 10),
              InputTextForm('First Name'.tr(context), 'Yeunjae', context),
              InputTextForm('Last Name'.tr(context), 'Kim', context),
              InputTextForm('Sex'.tr(context), 'Female', context),
              InputTextForm('Year of Birth'.tr(context), '1994', context),
              InputTextForm('Height'.tr(context), '000 cm', context),
              InputTextForm('Weight'.tr(context), '00 kg', context),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  'Account'.tr(context),
                  style: context.textStyleTheme.b20Medium.copyWith(
                      color: context.colorTheme.neutral.shade10),
                ),
              ),
              const SizedBox(height: 10),
              InputTextForm(
                  'Email ID'.tr(context), 'soundable@soundable.com', context),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 24),
                child: Text(
                  'Password'.tr(context),
                  style:context.textStyleTheme.b14Medium.copyWith(
                      color: context.colorTheme.neutral.shade6),
                ),
              ),
              TextArrow(
                  title: "Change Password".tr(context),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return ChangePasswordModal();
                      },
                    );
                  }),
              TextArrow(
                  title: "Set Up Passcode".tr(context),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return SetupPasscodeModal();
                      },
                    );
                  }),
              TextArrow(
                  title: "Delete Account".tr(context),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return DeleteAccountModal();
                      },
                    );
                  }),
              SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}
