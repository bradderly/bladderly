// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/model/beverage_type_model.dart';
import 'package:bladderly/presentation/feature/input/intake_input/model/intake_input_beverage_model.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

class IntakeInputBeverageTypeWidget extends StatelessWidget {
  const IntakeInputBeverageTypeWidget({
    super.key,
    required this.onChanged,
    required this.beverageModel,
  });

  final ValueChanged<IntakeInputBeverageModel> onChanged;
  final IntakeInputBeverageModel? beverageModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          itemCount: BeverageTypeModel.values.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (MediaQuery.sizeOf(context).width - 48) / 2 / 64,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final beverageTypeModel = BeverageTypeModel.values[index];
            final isSelected = beverageTypeModel == beverageModel?.typeModel;

            return GestureDetector(
              onTap: () => beverageModel?.typeModel == beverageTypeModel
                  ? null
                  : onChanged(
                      switch (beverageModel) {
                        final IntakeInputBeverageModel beverageModel =>
                          beverageModel.copyWith(typeModel: beverageTypeModel),
                        _ => IntakeInputBeverageModel.onlyType(beverageTypeModel),
                      },
                    ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: isSelected ? context.colorTheme.paleLime.shade10 : null,
                  border: Border.all(
                    color: isSelected ? context.colorTheme.paleLime.shade70 : context.colorTheme.neutral.shade4,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Text(
                      beverageTypeModel.name.tr(context),
                      style: context.textStyleTheme.b16SemiBold.copyWith(
                        color: isSelected ? context.colorTheme.paleLime.shade70 : context.colorTheme.neutral.shade5,
                      ),
                    ),
                    const Spacer(),
                    switch (beverageTypeModel) {
                      BeverageTypeModel.water => Assets.icon.icInputWater,
                      BeverageTypeModel.caffeine => Assets.icon.icInputCaffeine,
                      BeverageTypeModel.soda => Assets.icon.icInputSoda,
                      BeverageTypeModel.juice => Assets.icon.icInputJuice,
                      BeverageTypeModel.alcohol => Assets.icon.icInputAlcohol,
                      BeverageTypeModel.others => Assets.icon.icInputOthers,
                    }
                        .svg(
                      colorFilter: ColorFilter.mode(
                        isSelected ? context.colorTheme.paleLime.shade70 : context.colorTheme.neutral.shade5,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (beverageModel case final IntakeInputBeverageModel beverageModel
            when beverageModel.typeModel == BeverageTypeModel.others) ...[
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
                      'What beverage did you have?'.tr(context),
                      style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
                    ),
                    const Gap(16),
                    TextFormField(
                      onChanged: (value) => onChanged(beverageModel.copyWith(typeValue: value)),
                      initialValue: beverageModel.typeValue,
                      scrollPadding: const EdgeInsets.only(bottom: 12),
                      autocorrect: false,
                      enableSuggestions: false,
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
                        hintText: 'Type your beverage here'.tr(context),
                      ),
                      style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
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
