import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class CommonKeyboardActions extends StatelessWidget {
  const CommonKeyboardActions({
    super.key,
    required this.focusNode,
    required this.child,
  });

  final FocusNode focusNode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: KeyboardActionsConfig(
        keyboardBarColor: const Color(0xFFD1D5DB),
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        nextFocus: false,
        actions: [
          KeyboardActionsItem(
            focusNode: focusNode,
            displayDoneButton: false,
            displayActionBar: false,
            footerBuilder: (context) => PreferredSize(
              preferredSize: const Size.fromHeight(51),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Done'.tr(context),
                      style: context.textStyleTheme.b16SemiBold
                          .copyWith(color: context.colorTheme.vermilion.primary.shade50),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}
