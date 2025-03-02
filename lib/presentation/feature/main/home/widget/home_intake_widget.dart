// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/model/beverage_type_model.dart';
import 'package:bladderly/presentation/feature/main/home/model/home_intake_summary_model.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';

class HomeIntakeWidget extends StatelessWidget {
  const HomeIntakeWidget({
    super.key,
    required this.onTapMore,
    required this.homeIntakeSummaryModel,
  });

  final VoidCallback onTapMore;
  final HomeIntakeSummaryModel homeIntakeSummaryModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0XFFF9FAF6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: context.shadowTheme.shadow1,
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const Gap(16),
          Divider(color: context.colorTheme.neutral.shade4, thickness: 1),
          const Gap(24),
          _buildBeverageType(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          'Intake'.tr(context),
          style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
        ),
        const Spacer(),
        Container(
          width: 80,
          height: 31,
          decoration: BoxDecoration(
            border: Border.all(color: context.colorTheme.paleLime.shade70, width: 2),
            color: context.colorTheme.paleLime.shade10,
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          child: Text(
            '${context.unitValue(homeIntakeSummaryModel.totalVolume)}${context.unitName}',
            style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.paleLime.shade70),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTapMore,
          child: ColoredBox(
            color: Colors.transparent,
            child: Text(
              'See more'.tr(context),
              style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBeverageType(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (row) {
          if (row.isOdd) return const Gap(16);

          return SizedBox(
            height: 125,
            child: LayoutBuilder(
              builder: (context, constraints) => OverflowBox(
                maxWidth: double.infinity,
                child: SizedBox(
                  width: constraints.maxWidth < 318 ? null : constraints.maxWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(3, (column) {
                      final index = (row ~/ 2 * 3) + column;
                      final baverageType = BeverageTypeModel.values[index];

                      return GestureDetector(
                        onTap: () => IntakeInputRoute.fromBeverageType(beverageType: baverageType).push<void>(context),
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(23.54),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x1EB2B78C),
                                    blurRadius: 7.36,
                                    offset: Offset(0, 2.94),
                                  ),
                                  BoxShadow(
                                    color: Color(0x26B1B68B),
                                    blurRadius: 11.77,
                                    offset: Offset(0, 5.89),
                                    spreadRadius: 4.41,
                                  ),
                                ],
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Center(
                                    child: switch (baverageType) {
                                      BeverageTypeModel.water => Assets.icon.icHomeWater.svg(),
                                      BeverageTypeModel.caffeine => Assets.icon.icHomeCaffeine.svg(),
                                      BeverageTypeModel.soda => Assets.icon.icHomeSoda.svg(),
                                      BeverageTypeModel.juice => Assets.icon.icHomeJuice.svg(),
                                      BeverageTypeModel.alcohol => Assets.icon.icHomeAlcohol.svg(),
                                      BeverageTypeModel.others => Assets.icon.icHomeOthers.svg(),
                                    },
                                  ),
                                  Positioned(
                                    top: 5.89,
                                    right: 2.89,
                                    child: Assets.icon.icHomeAdd.svg(),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(8),
                            Text(
                              baverageType.name.tr(context),
                              style:
                                  context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
