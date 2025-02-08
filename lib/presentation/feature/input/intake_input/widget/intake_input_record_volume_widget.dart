import 'package:bradderly/domain/model/unit.dart';
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/input/formatter/input_volume_input_formatter.dart';
import 'package:bradderly/presentation/feature/input/intake_input/model/intake_input_drink_volume_model.dart';
import 'package:bradderly/presentation/feature/input/widget/input_unit_dropdown_button.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IntakeInputRecordVolumeWidget extends StatefulWidget {
  const IntakeInputRecordVolumeWidget({
    super.key,
    required this.focusNode,
    required this.onChangedVolume,
    required this.onChangedUnit,
    required this.recordVolumeModel,
    required this.unit,
  });

  final FocusNode focusNode;
  final ValueChanged<IntakeInputRecordVolumeModel> onChangedVolume;
  final ValueChanged<Unit> onChangedUnit;
  final IntakeInputRecordVolumeModel? recordVolumeModel;
  final Unit unit;

  @override
  State<IntakeInputRecordVolumeWidget> createState() => _IntakeInputRecordVolumeWidgetState();
}

class _IntakeInputRecordVolumeWidgetState extends State<IntakeInputRecordVolumeWidget> {
  late final textEditingController = TextEditingController(text: widget.recordVolumeModel?.value);

  @override
  void didUpdateWidget(covariant IntakeInputRecordVolumeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.recordVolumeModel case final IntakeInputRecordVolumeModel recordVolumeModel
        when oldWidget.unit != widget.unit) {
      widget.onChangedVolume(recordVolumeModel.copyWith(value: textEditingController.text = ''));
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            IntakeInputRecordVolumeModel.values.length,
            (index) {
              final recordVolumeModel = IntakeInputRecordVolumeModel.values[index];
              final isSelected = recordVolumeModel.runtimeType == widget.recordVolumeModel.runtimeType;

              return GestureDetector(
                onTap: () => widget.onChangedVolume(recordVolumeModel),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? context.colorTheme.paleLime.shade70 : context.colorTheme.neutral.shade4,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        color: isSelected ? context.colorTheme.paleLime.shade10 : null,
                      ),
                      child: recordVolumeModel.icon.svg(
                        colorFilter: isSelected
                            ? ColorFilter.mode(
                                context.colorTheme.paleLime.shade70,
                                BlendMode.srcIn,
                              )
                            : null,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      recordVolumeModel.type.tr(context),
                      style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                    ),
                    if (recordVolumeModel.typeValue.isNotEmpty)
                      Text(
                        '${widget.unit.parseFromMl(int.parse(recordVolumeModel.typeValue.tr(context)))}${widget.unit.name}',
                        style: context.textStyleTheme.b12SemiBold.copyWith(color: context.colorTheme.neutral.shade6),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        if (widget.recordVolumeModel case final IntakeInputDrinkMoreVolumeModel recordVolumeModel) ...[
          const Gap(24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.icon.icInputArrowRight.svg(),
              const Gap(5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please specify the amount'.tr(context),
                      style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) => widget.onChangedVolume(recordVolumeModel.copyWith(value: value)),
                            controller: textEditingController,
                            focusNode: widget.focusNode,
                            scrollPadding: const EdgeInsets.only(bottom: 12),
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.only(bottom: 12),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: context.colorTheme.paleLime.shade60, width: 2),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: context.colorTheme.paleLime.shade60, width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: context.colorTheme.paleLime.shade60, width: 2),
                              ),
                              hintText: 'Enter the amount here'.tr(context),
                            ),
                            style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
                            inputFormatters: [
                              InputVolumeFormatter(unit: widget.unit),
                            ],
                          ),
                        ),
                        const Gap(24),
                        InputUnitDropdownButton(
                          onChangedUnit: widget.onChangedUnit,
                          unit: widget.unit,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
