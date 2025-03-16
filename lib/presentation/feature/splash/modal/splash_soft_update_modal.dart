import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_modal.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashSoftUpdateModal extends StatelessWidget {
  const SplashSoftUpdateModal._({
    required this.onTapUpdate,
    required this.onTapLater,
  });

  final VoidCallback onTapUpdate;
  final VoidCallback onTapLater;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onTapUpdate,
    required VoidCallback onTapLater,
  }) async {
    return CommonModal.show<void>(
      context,
      child: SplashSoftUpdateModal._(
        onTapUpdate: onTapUpdate,
        onTapLater: onTapLater,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Optional Update title'.tr(context),
          style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
        ),
        const Gap(24),
        Text(
          'Optional Update body'.tr(context),
          style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade7),
        ),
        const Gap(32),
        PrimaryButton.filled(
          onPressed: onTapUpdate,
          backgroundColor: context.colorTheme.vermilion.primary.shade50,
          borderRadius: 400,
          shape: BoxShape.rectangle,
          text: 'Optional Update button 1'.tr(context),
          textColor: context.colorTheme.neutral.shade0,
          size: const Size.fromHeight(56),
        ),
        const Gap(8),
        PrimaryButton.filled(
          onPressed: onTapLater,
          backgroundColor: context.colorTheme.neutral.shade2,
          borderRadius: 400,
          shape: BoxShape.rectangle,
          text: 'Optional Update button 2'.tr(context),
          textColor: context.colorTheme.neutral.shade10,
          size: const Size.fromHeight(56),
        ),
      ],
    );
  }
}
