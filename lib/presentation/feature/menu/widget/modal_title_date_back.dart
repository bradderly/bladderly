// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';

// ignore: non_constant_identifier_names
Widget ModalTitleDateBack(BuildContext context, String date, String time) {
  return SizedBox(
    width: double.infinity,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Text(
              date,
              style: context.textStyleTheme.b16SemiBold.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
            ),
            Text(
              time,
              style: context.textStyleTheme.b14SemiBold.copyWith(
                color: context.colorTheme.neutral.shade6,
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: context.colorTheme.neutral.shade10,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    ),
  );
}
