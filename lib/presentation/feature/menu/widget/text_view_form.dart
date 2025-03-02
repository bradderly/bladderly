// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';

// ignore: non_constant_identifier_names
Widget TextViewForm(String title, String value, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textStyleTheme.b14Medium.copyWith(
            color: context.colorTheme.neutral.shade6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: context.textStyleTheme.b16Medium.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
      ],
    ),
  );
}
