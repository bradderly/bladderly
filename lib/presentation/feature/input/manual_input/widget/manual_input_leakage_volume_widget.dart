import 'dart:math';

import 'package:bladderly/domain/model/leakage_volume.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ManualInputLeakageVolumeWidget extends StatelessWidget {
  const ManualInputLeakageVolumeWidget({
    super.key,
    required this.onChanged,
    required this.leakageVolume,
  });

  final ValueChanged<LeakageVolume> onChanged;
  final LeakageVolume? leakageVolume;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        max(0, LeakageVolume.values.length * 2 - 1),
        (index) {
          if (index.isOdd) return const Gap(16);

          final value = LeakageVolume.values[index ~/ 2];
          final isSelected = leakageVolume == value;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(value),
              child: Container(
                alignment: Alignment.center,
                height: 54,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        isSelected ? context.colorTheme.vermilion.secondary.shade20 : context.colorTheme.neutral.shade2,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(112.5),
                  color:
                      isSelected ? context.colorTheme.vermilion.secondary.shade10 : context.colorTheme.neutral.shade2,
                ),
                child: Text(
                  LeakageVolume.values[index ~/ 2].name.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color:
                        isSelected ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
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
