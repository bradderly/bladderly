// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/feature/menu/widget/reason_option.dart';
import 'package:flutter/material.dart';

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
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
      child: Column(
        children: [
          ModalAppBar(title: 'Cancel plan'.tr(context)),
          const SizedBox(height: 58),
          Expanded(
            child: ListView(
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
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (selectedReason == null) {
                return;
              }
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
  }
}
