import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModalAppBar extends AppBar {
  ModalAppBar({
    super.key,
    String? title,
    bool backButton = true,
  }) : super(
          automaticallyImplyLeading: false,
          leading: backButton
              ? Builder(
                  builder: (context) => IconButton(
                    onPressed: context.pop,
                    icon: Assets.icon.icCommonArrowBack.svg(),
                  ),
                )
              : null,
          title: Builder(
            builder: (context) => Text(
              title!,
              style: context.textStyleTheme.b16SemiBold.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
            ),
          ),
          actions: [
            if (!backButton)
              Builder(
                builder: (context) => IconButton(
                  onPressed: context.pop,
                  icon: Icon(
                    Icons.close,
                    color: context.colorTheme.neutral.shade10,
                  ),
                ),
              ),
          ],
          toolbarHeight: 92,
        );
}
