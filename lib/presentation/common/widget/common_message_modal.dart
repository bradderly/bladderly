import 'package:bladderly/domain/exception/domain_exception.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_modal.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommonMessageModal extends StatelessWidget {
  const CommonMessageModal._({
    required this.content,
    this.onTap,
    this.title,
    this.buttonText,
  });

  final VoidCallback? onTap;
  final String? title;
  final String content;
  final String? buttonText;

  static Future<T?> show<T>(
    BuildContext context, {
    required VoidCallback onTap,
    required String content,
    String? title,
    String? buttonText,
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CommonMessageModal._(
        content: content,
        onTap: onTap,
        title: title,
        buttonText: buttonText,
      ),
    );
  }

  static Future<T?> showFromDominException<T>(
    BuildContext context, {
    required VoidCallback onTap,
    required DomainException exception,
    String? buttonText,
    bool barrierDismissible = false,
  }) {
    return show<T>(
      context,
      onTap: onTap,
      title: exception.title,
      content: exception.message,
      buttonText: buttonText,
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonModal(
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
            text: (buttonText ?? 'Okay').tr(context),
            textColor: context.colorTheme.neutral.shade0,
            size: const Size.fromHeight(56),
          ),
        ],
      ),
    );
  }
}
