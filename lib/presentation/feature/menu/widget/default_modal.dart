// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';

class DefaultModal extends StatelessWidget {
  const DefaultModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    ModalTitle(context, 'Plan'.tr(context)),
                    const SizedBox(height: 75.5),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Plan'.tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(
                          color: context.colorTheme.neutral.shade6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade6,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Restore'.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
