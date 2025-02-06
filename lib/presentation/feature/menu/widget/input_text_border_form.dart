import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

Widget InputTextBorderForm(
    String title, String value, int maxlines, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textStyleTheme.b14Medium
              .copyWith(color: context.colorTheme.neutral.shade6),
        ),
        SizedBox(height: 11),
        Container(
          decoration: BoxDecoration(

          color: context.colorTheme.neutral.shade2,
            border: Border.all(
              color: context.colorTheme.neutral.shade5,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            maxLines: maxlines,
            style: context.textStyleTheme.b16Medium
          .copyWith(color: context.colorTheme.neutral.shade10),
            decoration: InputDecoration(
              hintText: value,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              hintStyle: context.textStyleTheme.b16Medium.copyWith(
                color: context.colorTheme.neutral.shade6,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}
