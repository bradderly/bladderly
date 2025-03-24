import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class PasscodeDotWidget extends StatelessWidget {
  const PasscodeDotWidget({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < count ? context.colorTheme.neutral.shade6 : Colors.transparent,
            border: Border.all(color: context.colorTheme.neutral.shade6),
          ),
        ),
      ),
    );
  }
}
