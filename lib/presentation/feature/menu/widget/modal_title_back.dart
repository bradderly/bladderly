import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget ModalTitleBack(BuildContext context, String title) {
  return SizedBox(
    width: double.infinity,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Text(
          title,
          style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
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
