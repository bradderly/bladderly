import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:bradderly/presentation/feature/diary/detailed_list/model/detailed_list_history_model.dart';
import 'package:bradderly/presentation/feature/diary/detailed_list/widget/detailed_list_history_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DetailedListHistoriesWidget extends StatelessWidget {
  const DetailedListHistoriesWidget({
    super.key,
    required this.onTapEdit,
    required this.onTapDelete,
    required this.recordTime,
    required this.historyKeys,
    required this.histories,
  });

  final void Function(int id) onTapEdit;
  final void Function(int id) onTapDelete;
  final DateTime recordTime;
  final List<GlobalObjectKey> historyKeys;
  final List<DetailedListHistoryModel> histories;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                switch (context.locale) {
                  AppLocale.en => DateFormat('hh:mm\na').format(recordTime),
                  AppLocale.ko => DateFormat('a\nhh:mm', context.locale.name).format(recordTime),
                },
                style: context.textStyleTheme.b14SemiBold.copyWith(color: const Color(0xFF5E5E5E)),
                textAlign: TextAlign.center,
              ),
              const Gap(12),
              Expanded(
                child: Container(
                  width: 1,
                  color: const Color(0xFFC2C2C2),
                ),
              ),
            ],
          ),
          const Gap(20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Column(
                children: List.generate(
                  histories.length * 2 - 1,
                  (index) => DetailedListHistoryWidget(
                    key: historyKeys.firstWhereOrNull((element) => element.value == histories[index ~/ 2].id),
                    onTapEdit: onTapEdit,
                    onTapDelete: onTapDelete,
                    historyModel: histories[index ~/ 2],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
