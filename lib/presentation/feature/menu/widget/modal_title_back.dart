// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';

class ModalTitleBack extends StatelessWidget {
  const ModalTitleBack({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: context.textStyleTheme.b16SemiBold.copyWith(
              color: context.colorTheme.neutral.shade10,
            ),
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
}
