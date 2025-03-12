import 'dart:io';

import 'package:bladderly/domain/exception/domain_exception.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_modal.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonUpdateModal extends StatelessWidget {
  const CommonUpdateModal._({
    required this.content,
    this.onTap, // 다시 안보기 용도 사용?
    this.title,
  });

  final VoidCallback? onTap;
  final String? title;
  final String content;

  static Future<T?> show<T>(
    BuildContext context, {
    required String content,
    VoidCallback? onTap,
    String? title,
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CommonUpdateModal._(
        content: content,
        onTap: onTap,
        title: title,
      ),
    );
  }

  static Future<T?> showFromDominException<T>(
    BuildContext context, {
    required DomainException exception,
    VoidCallback? onTap,
    bool barrierDismissible = false,
  }) {
    return show<T>(
      context,
      onTap: onTap,
      title: exception.title,
      content: exception.message,
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonModal(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title case final String title) ...[
              Text(
                title.tr(context),
                style: context.textStyleTheme.b20Bold.copyWith(
                  color: context.colorTheme.neutral.shade10,
                ),
              ),
              const Gap(24),
            ],
            Text(
              content.tr(context),
              style: context.textStyleTheme.b16Medium.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
            ),
            const Gap(24),
            PrimaryButton.filled(
              onPressed: () async {
                String storeUrl;
                if (Platform.isAndroid) {
                  storeUrl = 'https://play.google.com/store/apps/details?id=com.soundable.diaryandroid.us';
                } else if (Platform.isIOS) {
                  storeUrl = 'https://apps.apple.com/app/id1523268654';
                } else {
                  if (kDebugMode) {
                    print('지원하지 않는 플랫폼입니다.');
                  }
                  return;
                }

                final url = Uri.parse(storeUrl);

                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $storeUrl';
                }
              },
              backgroundColor: context.colorTheme.vermilion.primary.shade50,
              borderRadius: 400,
              shape: BoxShape.rectangle,
              text: 'Update Now'.tr(context),
              textColor: context.colorTheme.neutral.shade0,
              size: const Size.fromHeight(56),
            ),
          ],
        ),
      ),
    );
  }
}
