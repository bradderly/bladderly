// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bladderly/presentation/feature/menu/widget/text_arrow_form.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';

class AboutModal extends StatelessWidget {
  const AboutModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) => Container(
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
            ModalTitle(context, 'Terms of Use'.tr(context)),
            const SizedBox(height: 75.5),
            TextArrow(
              title: 'Terms of Use'.tr(context),
              onTap: () => const TermsRoute().go(context),
            ),
            TextArrow(
              title: 'Privacy Policy'.tr(context),
              onTap: () => const PrivacyRoute().go(context),
            ),
          ],
        ),
      ),
    );
  }
}
