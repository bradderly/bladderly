// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';

class FaqViewModal extends StatelessWidget {
  const FaqViewModal({super.key});

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
              ModalTitle(context, 'FAQ'.tr(context)),
              const SizedBox(height: 20),
              //웹뷰 위치
            ],
          ),
        );
      },
    );
  }
}
