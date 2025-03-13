// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_modal.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DetailedListDeleteHistoryModal extends StatelessWidget {
  const DetailedListDeleteHistoryModal({super.key});

  static Future<bool> show(BuildContext context) async {
    return CommonModal.show<bool>(
      context,
      child: const DetailedListDeleteHistoryModal(),
    ).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delete Message'.tr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        const Gap(24),
        PrimaryButton.filled(
          onPressed: () => context.pop(true),
          backgroundColor: context.colorTheme.neutral.shade2,
          borderRadius: 400,
          shape: BoxShape.rectangle,
          text: 'Yes, Delete the record'.tr(context),
          textColor: context.colorTheme.neutral.shade10,
          size: const Size.fromHeight(56),
        ),
        const Gap(16),
        PrimaryButton.filled(
          onPressed: () => context.pop(false),
          backgroundColor: context.colorTheme.vermilion.primary.shade50,
          borderRadius: 400,
          shape: BoxShape.rectangle,
          text: 'No, Keep the record'.tr(context),
          textColor: context.colorTheme.neutral.shade0,
          size: const Size.fromHeight(56),
        ),
      ],
    );
  }
}
