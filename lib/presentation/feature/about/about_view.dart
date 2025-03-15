// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/feature/menu/widget/text_arrow_form.dart';
import 'package:bladderly/presentation/router/route/about_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(title: 'Terms of Use'.tr(context)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          controller: ModalScrollController.of(context),
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
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
        ),
      ),
    );
  }
}
