import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/widget/modal_title_back.dart';
import 'package:flutter/material.dart';

class SymptomDescriptModal extends StatelessWidget {
  const SymptomDescriptModal({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    ModalTitleBack(context, 'IPSS & OABSS'.tr(context)),
                    const SizedBox(height: 39.5),
                    SymptomDescriptForm(
                      context,
                      'IPSS',
                      '(Urinary Health Test)',
                      '1. Barry MJ, et al.  American Urological Association symptom index for benign prostatic hyperplasia. Journal of Urology, 1992',
                    ),
                    const SizedBox(height: 56),
                    SymptomDescriptForm(
                      context,
                      'OABSS',
                      '(Overactive Bladder Test)',
                      '1. Barry MJ, et al.  American Urological Association symptom index for benign prostatic hyperplasia. Journal of Urology, 1992',
                    ),
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

// ignore: lines_longer_than_80_chars, non_constant_identifier_names
Widget SymptomDescriptForm(
  BuildContext context,
  String title,
  String semititle,
  String description,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textStyleTheme.b20Bold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        Text(
          semititle,
          style: context.textStyleTheme.b16SemiBold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.colorTheme.neutral.shade2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            description,
            style: context.textStyleTheme.b16Medium
                .copyWith(color: context.colorTheme.neutral.shade9),
          ),
        ),
      ],
    ),
  );
}
