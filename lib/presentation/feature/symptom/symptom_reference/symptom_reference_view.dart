// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SymptomReferenceView extends StatelessWidget {
  const SymptomReferenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(
        title: 'References'.tr(context),
        backgroundColor: Colors.transparent,
        backButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            controller: ModalScrollController.of(context),
            physics: const ClampingScrollPhysics(),
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
                        style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade9),
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
                        style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
