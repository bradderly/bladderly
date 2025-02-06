
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/plan/privacy_view.dart';
import 'package:bradderly/presentation/feature/menu/plan/terms_view.dart';
import 'package:bradderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bradderly/presentation/feature/menu/widget/text_arrow.dart';
import 'package:flutter/material.dart';

class AboutModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
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
                    ModalTitle(context, 'Terms of Use'.tr(context)),
                    const SizedBox(height: 75.5),
                   
                    TextArrow(
                  title: "Terms of Use".tr(context),
                  onTap: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsView()),
                    );
                  }),
                   TextArrow(
                  title: "Privacy Policy".tr(context),
                  onTap: () {
                     
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivacyView()),
                    );
                  }),
                  ],
                ),
              ),
             
            ],
          ),
        );
      },
    );
  }
}
