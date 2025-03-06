// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title_back.dart';

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
              ModalTitleBack(context, 'IPSS & OABSS'.tr(context)),
              const SizedBox(height: 39.5),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'IPSS',
                            style: context.textStyleTheme.b20Bold.copyWith(
                              color: context.colorTheme.neutral.shade10,
                            ),
                          ),
                          Text(
                            '(International Prostate Symptom Score)',
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
                              'Barry MJ, et al.  American Urological Association symptom index for benign prostatic hyperplasia. Journal of Urology, 1992',
                              style:
                                  context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 56),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'OABSS',
                            style: context.textStyleTheme.b20Bold.copyWith(
                              color: context.colorTheme.neutral.shade10,
                            ),
                          ),
                          Text(
                            '(Overactive Bladder Test)',
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
                              'Homma Y, et al. Symptom assessment tool for overactive bladder syndrome - overactive bladder symptom score. Urology, 2006',
                              style:
                                  context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade9),
                            ),
                          ),
                        ],
                      ),
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
