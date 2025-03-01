// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';

class CupertinoDatePickerModal extends StatefulWidget {
  const CupertinoDatePickerModal({
    super.key,
    required this.selectedDate,
  });

  final DateTime selectedDate;

  static Future<DateTime?> show(
    BuildContext context, {
    required DateTime selectedDate,
  }) {
    return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (context) => CupertinoDatePickerModal(selectedDate: selectedDate),
    );
  }

  @override
  State<CupertinoDatePickerModal> createState() => _CupertinoDatePickerModalState();
}

class _CupertinoDatePickerModalState extends State<CupertinoDatePickerModal> {
  late DateTime selectedDate = widget.selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 23 + MediaQuery.paddingOf(context).bottom),
      height: 308,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: context.colorTheme.neutral.shade0,
        child: Column(
          children: [
            Expanded(
              child: Localizations.override(
                context: context,
                locale: Locale(context.locale.name),
                child: CupertinoDatePicker(
                  onDateTimeChanged: (dateTime) => selectedDate = dateTime,
                  initialDateTime: widget.selectedDate,
                  maximumDate: DateTime.now(),
                  selectionOverlayBuilder: (context, {required columnCount, required selectedIndex}) =>
                      const CupertinoPickerDefaultSelectionOverlay(capEndEdge: false, capStartEdge: false),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: context.colorTheme.neutral.shade5,
              height: 1,
            ),
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: Navigator.of(context).pop,
                      behavior: HitTestBehavior.translucent,
                      child: Center(
                        child: Text(
                          'Cancel'.tr(context),
                          style: context.textStyleTheme.b16Regular.copyWith(color: context.colorTheme.neutral.shade10),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(selectedDate),
                      behavior: HitTestBehavior.translucent,
                      child: Center(
                        child: Text(
                          'Done'.tr(context),
                          style: context.textStyleTheme.b16Regular.copyWith(color: context.colorTheme.neutral.shade10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
