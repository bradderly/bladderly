// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';

// ignore: non_constant_identifier_names
Widget InputTextForm(String title, String value, BuildContext context) {
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
        TextFormField(
          initialValue: value,
          style: context.textStyleTheme.b16Medium.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(
              bottom: 8,
              top: 2,
            ), // Adjust this value to move the underline closer
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.colorTheme.neutral.shade5,
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
