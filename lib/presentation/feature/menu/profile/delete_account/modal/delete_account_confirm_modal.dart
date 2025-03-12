import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_modal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountConfirmModal extends StatelessWidget {
  const DeleteAccountConfirmModal._({
    required this.onConfirm,
  });

  final VoidCallback onConfirm;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirm,
  }) {
    return CommonModal.show(
      context,
      child: DeleteAccountConfirmModal._(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delete account popup Message'.tr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
        ),
        const SizedBox(height: 32),
        Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onConfirm,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 19, bottom: 18),
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade2,
                  borderRadius: BorderRadius.circular(400),
                ),
                child: Text(
                  'Yes, delete my account'.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: context.pop,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 19, bottom: 18),
                decoration: BoxDecoration(
                  color: context.colorTheme.vermilion.primary.shade50,
                  borderRadius: BorderRadius.circular(400),
                ),
                child: Text(
                  'No, keep my account'.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
