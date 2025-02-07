import 'package:bradderly/domain/model/unit.dart';
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ManualInputVoidingVolumeWidget extends StatelessWidget {
  const ManualInputVoidingVolumeWidget({
    super.key,
    required this.onChangedAmount,
    required this.onChangedUnit,
    required this.focusNode,
    required this.amount,
    required this.unit,
  });

  final ValueChanged<String> onChangedAmount;
  final ValueChanged<Unit> onChangedUnit;
  final FocusNode focusNode;
  final String amount;
  final Unit unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onChanged: onChangedAmount,
            focusNode: focusNode,
            initialValue: amount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              isDense: true,
              border: UnderlineInputBorder(borderSide: BorderSide(color: context.colorTheme.neutral.shade6)),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.colorTheme.neutral.shade6)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.colorTheme.neutral.shade6)),
              hintText: 'Please record your urine output'.tr(context),
              hintStyle: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
              contentPadding: const EdgeInsets.symmetric(horizontal: 4).copyWith(bottom: 13),
              counterText: '',
            ),
            style: context.textStyleTheme.b20Medium.copyWith(color: context.colorTheme.neutral.shade10),
            maxLength: switch (unit) {
              Unit.ml => 4,
              Unit.oz => 2,
            },
          ),
        ),
        const Gap(22),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            onChanged: (value) {
              if (value is Unit) onChangedUnit(value);
            },
            value: unit,
            customButton: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: context.colorTheme.neutral.shade3,
              ),
              child: Row(
                children: [
                  Text(
                    unit.name,
                    style: context.textStyleTheme.b16Medium.copyWith(
                      color: context.colorTheme.neutral.shade10,
                    ),
                  ),
                  const Gap(8),
                  Assets.icon.icInputDownArrow.svg(),
                ],
              ),
            ),
            items: List.generate(
              Unit.values.length * 2 - 1,
              (index) {
                if (index.isOdd) return const DropdownMenuItem<Divider>(child: Divider(thickness: 1, height: 1));

                final value = Unit.values[index ~/ 2];
                final isSelected = unit == value;
                return DropdownMenuItem<Unit>(
                  value: value,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Text(
                      value.name,
                      style: context.textStyleTheme.b16Medium.copyWith(
                        color: isSelected
                            ? context.colorTheme.vermilion.primary.shade50
                            : context.colorTheme.neutral.shade10,
                      ),
                    ),
                  ),
                );
              },
            ),
            dropdownStyleData: DropdownStyleData(
              width: 72,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: context.colorTheme.neutral.shade3,
              ),
              elevation: 0,
              offset: const Offset(0, -2),
              isOverButton: true,
            ),
            menuItemStyleData: MenuItemStyleData(
              padding: EdgeInsets.zero,
              customHeights: List.generate(
                Unit.values.length * 2 - 1,
                (index) => index.isOdd ? 1 : 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
