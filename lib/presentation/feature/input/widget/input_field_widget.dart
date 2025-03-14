// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:gap/gap.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
        ),
        const Gap(16),
        child,
      ],
    );
  }
}
