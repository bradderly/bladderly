// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bladderly/presentation/feature/menu/widget/text_arrow_form.dart';
import 'package:bladderly/presentation/router/route/about_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
      child: Column(
        children: [
          ModalTitle(title: 'Terms of Use'.tr(context)),
          const SizedBox(height: 75.5),
          TextArrow(
            onTap: () => const TermsRoute().go(context),
            title: 'Terms of Use'.tr(context),
          ),
          TextArrow(
            onTap: () => const PrivacyRoute().go(context),
            title: 'Privacy Policy'.tr(context),
          ),
        ],
      ),
    );
  }
}
