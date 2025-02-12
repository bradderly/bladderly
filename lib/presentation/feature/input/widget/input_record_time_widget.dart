import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/datetime_extension.dart';
import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:bradderly/presentation/common/widget/cupertino_date_picker_modal.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class InputRecordTimeWidget extends StatelessWidget {
  const InputRecordTimeWidget({
    super.key,
    this.onChanged,
    required this.dateTime,
  });

  final ValueChanged<DateTime>? onChanged;
  final DateTime dateTime;

  Future<void> _onTap(
    BuildContext context, {
    required DateTime selectedDate,
  }) async {
    final dateTime = await CupertinoDatePickerModal.show(context, selectedDate: selectedDate);

    if (dateTime != null) {
      onChanged?.call(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context, selectedDate: dateTime),
      behavior: HitTestBehavior.translucent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dateTime.getDayMonthDateTr(context),
                style: context.textStyleTheme.b16SemiBold.copyWith(
                  color: context.colorTheme.neutral.shade10,
                ),
              ),
              Text(
                switch (context.locale) {
                  AppLocale.en => DateFormat('hh:mm a').format(dateTime),
                  AppLocale.ko => DateFormat('a hh:mm').format(dateTime),
                },
                style: context.textStyleTheme.b14SemiBold.copyWith(
                  color: context.colorTheme.neutral.shade7,
                ),
              ),
            ],
          ),
          if (onChanged != null) ...[
            const Gap(6),
            Assets.icon.icInputUpdate.svg(),
          ],
        ],
      ),
    );
  }
}
