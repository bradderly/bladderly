import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_modal.dart';
import 'package:flutter/material.dart';

class SignOutModal extends StatelessWidget {
  const SignOutModal._();

  static Future<void> show(BuildContext context) {
    return CommonModal.show(
      context,
      child: const SignOutModal._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: Text(
            'Sign out Message'.tr(context),
            style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
          ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: context.signOut,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 19, bottom: 18),
            decoration: BoxDecoration(
              color: context.colorTheme.neutral.shade2,
              borderRadius: BorderRadius.circular(400),
            ),
            child: Text(
              'Yes, Sign Out'.tr(context),
              style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: Navigator.of(context).pop,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 19, bottom: 18),
            decoration: BoxDecoration(
              color: context.colorTheme.vermilion.primary.shade50,
              borderRadius: BorderRadius.circular(400),
            ),
            child: Text(
              'No, Keep Me Signed In'.tr(context),
              style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade0),
            ),
          ),
        ),
      ],
    );
  }
}
