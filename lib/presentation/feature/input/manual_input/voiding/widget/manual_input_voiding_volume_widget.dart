import 'package:bladderly/domain/model/unit.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/input/formatter/input_volume_input_formatter.dart';
import 'package:bladderly/presentation/feature/input/widget/input_unit_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ManualInputVoidingVolumeWidget extends StatefulWidget {
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
  State<ManualInputVoidingVolumeWidget> createState() => _ManualInputVoidingVolumeWidgetState();
}

class _ManualInputVoidingVolumeWidgetState extends State<ManualInputVoidingVolumeWidget> {
  late final textEditingController = TextEditingController(text: widget.amount);

  @override
  void didUpdateWidget(covariant ManualInputVoidingVolumeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.unit != widget.unit) {
      widget.onChangedAmount(textEditingController.text = '');
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: widget.onChangedAmount,
            controller: textEditingController,
            focusNode: widget.focusNode,
            keyboardType: TextInputType.number,
            autocorrect: false,
            enableSuggestions: false,
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
            inputFormatters: [
              InputVolumeFormatter(unit: widget.unit),
            ],
          ),
        ),
        const Gap(22),
        InputUnitDropdownButton(
          onChangedUnit: widget.onChangedUnit,
          unit: widget.unit,
        ),
      ],
    );
  }
}
