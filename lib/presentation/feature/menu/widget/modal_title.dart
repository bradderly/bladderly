// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';

class ModalTitle extends StatelessWidget {
  const ModalTitle({super.key, required this.title});
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
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.close,
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
