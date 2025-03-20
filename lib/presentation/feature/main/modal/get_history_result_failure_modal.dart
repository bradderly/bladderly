import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class GetHistoryResultFailureModal extends StatelessWidget {
  const GetHistoryResultFailureModal._({
    required this.onEdit,
    required this.onMaintain,
    required this.recordTime,
    required this.message,
  });

  final VoidCallback onEdit;
  final VoidCallback onMaintain;
  final DateTime recordTime;
  final String message;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onEdit,
    required VoidCallback onMaintain,
    required DateTime recordTime,
    required String message,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: context.colorTheme.neutral.shade0,
      builder: (context) => GetHistoryResultFailureModal._(
        onEdit: onEdit,
        onMaintain: onMaintain,
        recordTime: recordTime,
        message: message,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(48),
          Center(child: Assets.icon.icInputFailure.svg()),
          const Gap(24),
          Text(
            'Oops, we couldn’t analyze your results'.tr(context),
            style: context.textStyleTheme.b24Bold.copyWith(
              color: context.colorTheme.neutral.shade10,
            ),
          ),
          const Gap(16),
          Text(
            message.tr(context),
            style: context.textStyleTheme.b16Medium.copyWith(
              color: context.colorTheme.neutral.shade7,
            ),
          ),
          const Gap(24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: context.colorTheme.vermilion.secondary.shade5,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Issued records'.tr(context),
                  style: context.textStyleTheme.b14SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade6,
                  ),
                ),
                const Gap(16),
                Row(
                  children: [
                    Assets.icon.icInputWarning.svg(),
                    const Gap(8),
                    Text(
                      switch (context.locale) {
                        AppLocale.en => DateFormat('hh:mm a, MMMM dd, yyyy').format(recordTime),
                        AppLocale.ko => DateFormat('a hh:mm, yyyy년 MM월 dd일', context.locale.name).format(recordTime),
                      },
                      style: context.textStyleTheme.b14SemiBold.copyWith(
                        color: context.colorTheme.neutral.shade8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(16),
          PrimaryButton.filled(
            onPressed: onEdit,
            backgroundColor: context.colorTheme.vermilion.primary.shade50,
            borderRadius: 400,
            shape: BoxShape.rectangle,
            text: 'Add the void manually'.tr(context),
            textColor: context.colorTheme.neutral.shade0,
            size: const Size.fromHeight(56),
          ),
          const Gap(16),
          PrimaryButton.outlined(
            onPressed: onMaintain,
            backgroundColor: Colors.transparent,
            borderColor: context.colorTheme.vermilion.primary.shade50,
            borderWidth: 2,
            borderRadius: 400,
            shape: BoxShape.rectangle,
            text: 'Keep the record without data'.tr(context),
            textColor: context.colorTheme.vermilion.primary.shade50,
            size: const Size.fromHeight(56),
          ),
          const Gap(58),
        ],
      ),
    );
  }
}
