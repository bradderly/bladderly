// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';

class InputSaveButton extends StatelessWidget {
  const InputSaveButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => isKeyboardVisible
          ? const SizedBox.shrink()
          : PrimaryButton.filled(
              onPressed: onPressed,
              borderRadius: 8,
              text: 'Save'.tr(context),
              backgroundColor:
                  onPressed == null ? context.colorTheme.neutral.shade6 : context.colorTheme.vermilion.primary.shade50,
              shape: BoxShape.rectangle,
              textColor: context.colorTheme.neutral.shade0,
              size: const Size(256, 48),
            ),
    );
  }
}
