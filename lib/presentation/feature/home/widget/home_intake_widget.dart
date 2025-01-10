import 'package:bradderly/domain/model/beverage_type.dart';
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeIntakeWidget extends StatelessWidget {
  const HomeIntakeWidget({super.key});

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
          'Intake'.tr,
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
            '${context.unitValue(0)}${context.unit}',
            style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.paleLime.shade70),
          ),
        ),
        const Spacer(),
        Text(
          'See more'.tr,
          style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
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

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (column) {
              final index = (row ~/ 2 * 3) + column;
              final baverageType = BeverageType.values[index];

              return Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
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
                            BeverageType.water => Assets.icon.icHomeWater.svg(fit: BoxFit.cover),
                            BeverageType.caffeine => Assets.icon.icHomeCaffeine.svg(fit: BoxFit.cover),
                            BeverageType.soda => Assets.icon.icHomeSoda.svg(fit: BoxFit.cover),
                            BeverageType.juice => Assets.icon.icHomeJuice.svg(fit: BoxFit.cover),
                            BeverageType.alcohol => Assets.icon.icHomeAlcohol.svg(fit: BoxFit.cover),
                            BeverageType.others => Assets.icon.icHomeOthers.svg(fit: BoxFit.cover),
                          },
                        ),
                      ],
                    ),
                  ),
                  const Gap(8),
                  Text(
                    baverageType.name.tr,
                    style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}
