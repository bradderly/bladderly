// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bladderly/presentation/feature/menu/widget/reason_option.dart';

class DeleteAccountModal extends StatefulWidget {
  const DeleteAccountModal({super.key});

  @override
  State<DeleteAccountModal> createState() => _DeleteAccountModalState();
}

class _DeleteAccountModalState extends State<DeleteAccountModal> {
  String? selectedReason;

  final List<String> reasons = [
    'I am switching to different plans',
    'I achieved my goal',
    'I am not using enough',
    'I wasn’t satisfied with or had issues with the features, including technical difficulties',
    'I found an alternative service',
    'Other',
  ];

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
                    ModalTitle(context, 'Delete Account'.tr(context)),
                    const SizedBox(height: 58),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 32),
                      child: Text(
                        'Delete account Message'.tr(context),
                        style: context.textStyleTheme.b16Medium.copyWith(
                          color: context.colorTheme.neutral.shade10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 47),
                    ...reasons.map(
                      (reason) => ReasonOption(
                        reason: reason.tr(context),
                        isSelected: selectedReason == reason,
                        onSelect: () {
                          setState(() {
                            selectedReason = reason;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (selectedReason == null) {
                    return;
                  }
                  showDeleteAccountDialog(context, onConfirm: () {});
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                  decoration: BoxDecoration(
                    color: (selectedReason == null)
                        ? context.colorTheme.neutral.shade6
                        : context.colorTheme.vermilion.primary.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Next'.tr(context),
                    style: context.textStyleTheme.b16SemiBold.copyWith(
                      color: context.colorTheme.neutral.shade0,
                    ),
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

void showDeleteAccountDialog(
  BuildContext context, {
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  // ignore: inference_failure_on_function_invocation
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // 둥근 모서리
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete account popup Message'.tr(context),
              style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
            ),
            const SizedBox(height: 32),
            Column(
              children: [
                GestureDetector(
                  onTap: onConfirm,
                  child: Container(
                    alignment: Alignment.center,
                    height: 56,
                    decoration: BoxDecoration(
                      color: context.colorTheme.neutral.shade2,
                      borderRadius: BorderRadius.circular(400),
                    ),
                    child: Text(
                      'Yes, delete my account'.tr(context),
                      style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 56,
                    decoration: BoxDecoration(
                      color: context.colorTheme.vermilion.primary.shade50,
                      borderRadius: BorderRadius.circular(400),
                    ),
                    child: Text(
                      'No, keep my account'.tr(context),
                      style: context.textStyleTheme.b16SemiBold.copyWith(
                        color: context.colorTheme.neutral.shade0,
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
  );
}
