// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bladderly/presentation/feature/menu/widget/reason_option.dart';

class PlanCancelModal extends StatefulWidget {
  const PlanCancelModal({super.key});

  @override
  State<PlanCancelModal> createState() => _PlanCancelModalState();
}

class _PlanCancelModalState extends State<PlanCancelModal> {
  String? selectedReason;

  final List<String> reasons = [
    'I achieved my goal',
    'I think the service is too pricey',
    'I want to resume the subscription later on',
    'I have technical difficulties',
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
              ModalTitle(context, 'Cancel plan'.tr(context)),
              const SizedBox(height: 58),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 32),
                      child: Text(
                        'Delete account Message'.tr(context),
                        style: context.textStyleTheme.b16Medium.copyWith(
                          color: context.colorTheme.neutral.shade10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 59),
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
                  showDeletePlanDialog(
                    context,
                    onConfirm: () {
                      Navigator.pop(context);
                    },
                  );
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

void showDeletePlanDialog(
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
        contentPadding: const EdgeInsets.only(left: 32, top: 52, right: 32, bottom: 52),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your subscription has been canceled.'.tr(context),
              style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
            ),
            const SizedBox(height: 24),
            Text(
              'Cancel plan Message'.tr(context),
              style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                GestureDetector(
                  onTap: onConfirm,
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.colorTheme.vermilion.primary.shade50,
                      borderRadius: BorderRadius.circular(400),
                    ),
                    child: Text(
                      'Okay'.tr(context),
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
