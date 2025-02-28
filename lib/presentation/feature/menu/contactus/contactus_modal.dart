import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/input_text_border_form.dart';
import 'package:bladderly/presentation/feature/menu/widget/input_text_form.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';

class ContactusModal extends StatelessWidget {
  const ContactusModal({super.key});

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
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    ModalTitle(context, 'Contact us'.tr(context)),
                    const SizedBox(height: 42.5),
                    InputTextForm('First Name'.tr(context), 'Yeunjae', context),
                    InputTextForm('Last Name'.tr(context), 'Kim', context),
                    InputTextForm(
                      '${'Email Address'.tr(context)} *',
                      '000@email.com',
                      context,
                    ),
                    const SizedBox(height: 36),
                    InputTextBorderForm(
                      '${'Subject'.tr(context)} *',
                      'Please enter the subject',
                      1,
                      context,
                    ),
                    InputTextBorderForm(
                      '${'Subject'.tr(context)} *',
                      'Please enter the subject',
                      5,
                      context,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        '* Required fields',
                        style: context.textStyleTheme.b16Medium.copyWith(
                          color: context.colorTheme.neutral.shade6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade6,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Submit'.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
