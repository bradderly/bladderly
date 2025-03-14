import 'dart:math';

import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/util/text_size_util.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PaywallHeaderWidget extends StatelessWidget {
  const PaywallHeaderWidget({
    super.key,
    required this.isFreeUser,
  });

  final bool isFreeUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Assets.icon.icPaymentDiamond.svg(
          width: 80,
          height: 80,
        ),
        const Gap(16),
        Text(
          'Get Unlimited Access!'.tr(context),
          style: context.textStyleTheme.b24BoldOutfit.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        const Gap(8),
        Builder(
          builder: (context) {
            final texts = [
              'Automatic voiding volume measurement'.tr(context),
              'PDF export reports'.tr(context),
            ];

            final textStyle = context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10);

            final textWidth =
                texts.map((text) => TextSizeUtil.getSize(text: text, textStyle: textStyle).width).reduce(max);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  for (final text in texts)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icon.icPaymentCheck.svg(),
                        const Gap(8),
                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minWidth: textWidth),
                            child: Text(
                              text,
                              style: context.textStyleTheme.b14Medium.copyWith(
                                color: context.colorTheme.neutral.shade10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
