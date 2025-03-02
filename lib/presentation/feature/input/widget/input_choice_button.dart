// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';

class InputChoiceButton extends StatelessWidget {
  const InputChoiceButton({
    super.key,
    required this.onTap,
    required this.value,
  });

  final ValueChanged<bool> onTap;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildButton(context, isSelected: value == true, value: true)),
        const Gap(16),
        Expanded(child: _buildButton(context, isSelected: value == false, value: false)),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required bool isSelected,
    required bool value,
  }) {
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? context.colorTheme.vermilion.secondary.shade10 : context.colorTheme.neutral.shade3,
          border: isSelected
              ? Border.all(
                  color: context.colorTheme.vermilion.secondary.shade20,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignOutside,
                )
              : null,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          value ? 'Yes'.tr(context) : 'No'.tr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(
            color: isSelected ? context.colorTheme.vermilion.primary.shade40 : context.colorTheme.neutral.shade6,
          ),
        ),
      ),
    );
  }
}
