import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/common/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SoundInputRecordingCancelDialog extends StatelessWidget {
  const SoundInputRecordingCancelDialog({
    super.key,
    required this.onCancel,
    required this.onContinue,
  });

  final VoidCallback onCancel;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 48, bottom: 72),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure you want to cancel the recording?'.tr(context),
            style: context.textStyleTheme.b20Bold.copyWith(
              color: context.colorTheme.neutral.shade10,
            ),
          ),
          const Gap(40),
          PrimaryButton.outlined(
            onPressed: onCancel,
            size: const Size.fromHeight(56),
            backgroundColor: context.colorTheme.neutral.shade0,
            borderRadius: 400,
            shape: BoxShape.rectangle,
            text: 'Yes, Cancel recording'.tr(context),
            textColor: context.colorTheme.vermilion.primary.shade50,
            borderColor: context.colorTheme.vermilion.primary.shade50,
            borderWidth: 2,
          ),
          const Gap(8),
          PrimaryButton.filled(
            onPressed: onContinue,
            size: const Size.fromHeight(56),
            backgroundColor: context.colorTheme.vermilion.primary.shade50,
            borderRadius: 400,
            shape: BoxShape.rectangle,
            text: 'No, Continue recording'.tr(context),
            textColor: context.colorTheme.neutral.shade0,
          ),
        ],
      ),
    );
  }
}
