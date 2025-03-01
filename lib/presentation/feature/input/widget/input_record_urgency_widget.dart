// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';

class InputRecordUrgencyWidget extends StatelessWidget {
  const InputRecordUrgencyWidget({
    super.key,
    required this.onTap,
    this.recordUrgency,
  });

  final ValueChanged<int> onTap;
  final int? recordUrgency;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            5,
            (index) {
              final recordUrgency = index + 1;
              return _buildLevel(
                context,
                isSelected: recordUrgency == this.recordUrgency,
                level: recordUrgency,
              );
            },
          ),
        ),
        const Gap(3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'No urge'.tr(context),
              style: context.textStyleTheme.b14Medium.copyWith(
                color: context.colorTheme.neutral.shade6,
              ),
            ),
            Text(
              'Urgent'.tr(context),
              style: context.textStyleTheme.b14Medium.copyWith(
                color: context.colorTheme.neutral.shade6,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLevel(
    BuildContext context, {
    required bool isSelected,
    required int level,
  }) {
    return GestureDetector(
      onTap: () => onTap(level),
      child: Container(
        width: 54,
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? context.colorTheme.vermilion.secondary.shade10 : context.colorTheme.neutral.shade2,
          border: isSelected
              ? Border.all(
                  color: context.colorTheme.vermilion.secondary.shade20,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignOutside,
                )
              : null,
          shape: BoxShape.circle,
        ),
        child: Text(
          '$level',
          style: context.textStyleTheme.b18SemiBold.copyWith(
            color: isSelected ? context.colorTheme.vermilion.secondary.shade40 : context.colorTheme.neutral.shade6,
          ),
        ),
      ),
    );
  }
}
