// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  final String date = 'Effective Date: August 3, 2021';
  final String title =
      'Please carefully read all of the following terms and conditions fo the soundable health terms of use (“Soundable Health Terms.”)';
  final String content =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 43),
                ModalTitle(context, 'Terms of Use'.tr(context)),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 24, top: 25, right: 24),
                  child: Text(
                    date,
                    style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 24, top: 40, right: 24),
                  child: Text(
                    title,
                    style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 24, top: 16, right: 24),
                  child: Text(
                    content,
                    style: context.textStyleTheme.b16Regular.copyWith(color: context.colorTheme.neutral.shade8),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 24, top: 16, right: 24),
                  child: Text(
                    content,
                    style: context.textStyleTheme.b16Regular.copyWith(color: context.colorTheme.neutral.shade8),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 24, top: 16, right: 24),
                  child: Text(
                    content,
                    style: context.textStyleTheme.b16Regular.copyWith(color: context.colorTheme.neutral.shade8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
