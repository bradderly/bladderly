import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_modal.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SoundInputNoteUploadSuccessModal extends StatelessWidget {
  const SoundInputNoteUploadSuccessModal({
    super.key,
    required this.onGoToDiary,
  });

  final VoidCallback onGoToDiary;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onGoToDiary,
  }) {
    return CommonModal.show(
      context,
      child: SoundInputNoteUploadSuccessModal(onGoToDiary: onGoToDiary),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.icon.icInputUploadSuccess.svg(),
          const Gap(53),
          Text(
            'We received your recording!'.tr(context),
            style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
          ),
          const Gap(24),
          Text(
            'Analyzing Message'.tr(context),
            style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade7),
          ),
          const Gap(32),
          PrimaryButton.filled(
            onPressed: onGoToDiary,
            backgroundColor: context.colorTheme.neutral.shade2,
            borderRadius: 400,
            shape: BoxShape.rectangle,
            text: 'Go to Diary'.tr(context),
            textColor: context.colorTheme.neutral.shade10,
            size: const Size.fromHeight(56),
          ),
        ],
      ),
    );
  }
}
