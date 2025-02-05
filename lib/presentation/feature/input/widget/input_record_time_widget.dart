import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/datetime_extension.dart';
import 'package:flutter/material.dart';

class InputRecordTimeWidget extends StatelessWidget {
  const InputRecordTimeWidget({
    super.key,
    this.onTap,
    required this.dateTime,
  });

  final ValueChanged<DateTime>? onTap;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          dateTime.getDayMonthDateTr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        Text(
          dateTime.getHourMinuteWithAmPm(context),
          style: context.textStyleTheme.b14SemiBold.copyWith(
            color: context.colorTheme.neutral.shade7,
          ),
        ),
      ],
    );
  }
}
