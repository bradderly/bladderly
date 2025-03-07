import 'package:bladderly/domain/exception/domain_exception.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_modal.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommonErrorModal extends StatelessWidget {
  const CommonErrorModal._({
    required this.content,
    this.onTap,
    this.title,
  });

  final VoidCallback? onTap;
  final String? title;
  final String content;

  static Future<T?> show<T>(
    BuildContext context, {
    required String content,
    VoidCallback? onTap,
    String? title,
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CommonErrorModal._(
        content: content,
        onTap: onTap,
        title: title,
      ),
    );
  }

  static Future<T?> showFromDominException<T>(
    BuildContext context, {
    required DomainException exception,
    VoidCallback? onTap,
    bool barrierDismissible = false,
  }) {
    return show<T>(
      context,
      onTap: onTap,
      title: exception.title,
      content: exception.message,
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonModal(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title case final String title) ...[
              Text(
                title.tr(context),
                style: context.textStyleTheme.b20Bold.copyWith(
                  color: context.colorTheme.neutral.shade10,
                ),
              ),
              const Gap(24),
            ],
            Text(
              content.tr(context),
              style: context.textStyleTheme.b16Medium.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
            ),
            const Gap(24),
            PrimaryButton.filled(
              onPressed: onTap,
              backgroundColor: context.colorTheme.vermilion.primary.shade50,
              borderRadius: 400,
              shape: BoxShape.rectangle,
              text: 'Okay'.tr(context),
              textColor: context.colorTheme.neutral.shade0,
              size: const Size.fromHeight(56),
            ),
          ],
        ),
      ),
    );
  }
}
