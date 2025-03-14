import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ModalAppBar extends AppBar {
  ModalAppBar({
    super.key,
    super.backgroundColor,
    String? title,
    bool backButton = true,
    Color? iconColor,
    double toolbarHeight = 92,
  }) : super(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: backButton
              ? Builder(
                  builder: (context) => IconButton(
                    onPressed: context.pop,
                    icon: Assets.icon.icCommonArrowBack.svg(),
                  ),
                )
              : null,
          title: title == null
              ? null
              : Builder(
                  builder: (context) => Text(
                    title,
                    style: context.textStyleTheme.b16SemiBold.copyWith(
                      color: context.colorTheme.neutral.shade10,
                    ),
                  ),
                ),
          actions: backButton
              ? null
              : [
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: context.pop,
                      icon: Icon(
                        Icons.close,
                        color: iconColor ?? context.colorTheme.neutral.shade10,
                      ),
                    ),
                  ),
                  const Gap(4),
                ],
          toolbarHeight: toolbarHeight,
          systemOverlayStyle: backgroundColor == Colors.transparent ? SystemUiOverlayStyle.dark : null,
        );
}
