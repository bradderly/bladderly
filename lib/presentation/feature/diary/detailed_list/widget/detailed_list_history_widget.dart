// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/common/model/beverage_type_model.dart';
import 'package:bladderly/presentation/feature/diary/detailed_list/model/detailed_list_history_model.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:gap/gap.dart';

sealed class DetailedListHistoryWidget extends StatelessWidget {
  factory DetailedListHistoryWidget({
    required Key? key,
    required void Function(int id) onTapEdit,
    required void Function(int id) onTapDelete,
    required DetailedListHistoryModel historyModel,
  }) {
    return switch (historyModel) {
      DetailedListVoidingHistoryModel() => _DetailedListVoidingHistoryWidget(
          key: key,
          onTapEdit: onTapEdit,
          onTapDelete: onTapDelete,
          historyModel: historyModel,
        ),
      DetailedListLeakageHistoryModel() => _DetailedListLeakageHistoryWidget(
          key: key,
          onTapEdit: onTapEdit,
          onTapDelete: onTapDelete,
          historyModel: historyModel,
        ),
      DetailedListIntakeHistoryModel() => _DetailedListIntakeHistoryWidget(
          key: key,
          onTapEdit: onTapEdit,
          onTapDelete: onTapDelete,
          historyModel: historyModel,
        ),
    };
  }

  const DetailedListHistoryWidget._({
    required super.key,
    required this.onTapEdit,
    required this.onTapDelete,
    required this.historyModel,
  });

  final void Function(int id) onTapEdit;
  final void Function(int id) onTapDelete;
  final DetailedListHistoryModel historyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorTheme.neutral.shade0,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildHeader(context),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => onTapDelete(historyModel.id),
                    child: Assets.icon.icDetailedListDelete.svg(),
                  ),
                  const Gap(4),
                  GestureDetector(
                    onTap: () => onTapEdit(historyModel.id),
                    child: Assets.icon.icDetailedListUpdate.svg(),
                  ),
                ],
              ),
            ],
          ),
          if (historyModel is DetailedListVoidingHistoryModel &&
              (historyModel as DetailedListVoidingHistoryModel).recordVolume == 0)
            _buildNA(context),
          const Divider(color: Color(0xFFE6E6E6), thickness: 1, height: 35),
          _buildBody(context),
          _buildMemo(context),
        ],
      ),
    );
  }

  Color _getColor(BuildContext context);

  Widget _buildHistoryType(
    BuildContext context, {
    required String type,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.colorTheme.neutral.shade2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        type,
        style: context.textStyleTheme.b14SemiBold.copyWith(
          color: _getColor(context),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context);

  Widget _buildNA(BuildContext context) {
    return Column(
      children: [
        const Gap(8),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Assets.icon.icInputWarning.svg(),
            const Gap(8),
            Flexible(
              child: RichText(
                text: TextSpan(
                  style: context.textStyleTheme.b12Medium.copyWith(color: context.colorTheme.vermilion.primary.shade50),
                  children: switch (context.locale) {
                    AppLocale.en => [
                        TextSpan(text: 'Voided Volume Not Recorded.', style: context.textStyleTheme.b12SemiBold),
                        const TextSpan(text: ' Please manually record the amount to ensure accurate tracking.'),
                      ],
                    AppLocale.ko => [
                        TextSpan(text: '배뇨량이 기록되지 않았습니다.', style: context.textStyleTheme.b12SemiBold),
                        const TextSpan(text: ' 정확한 추적을 위해 수동으로 양을 기록해 주세요.'),
                      ]
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context);

  Widget _buildMemo(BuildContext context) {
    final historyModel = this.historyModel;

    final isBevarageTypeOthers = historyModel is DetailedListIntakeHistoryModel && historyModel.isBevarageTypeOthers;
    final isMemoNotEmpty = historyModel.memo?.trim().isNotEmpty ?? false;

    return Column(
      children: [
        if (isBevarageTypeOthers || isMemoNotEmpty) const Gap(16),
        if (isBevarageTypeOthers)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'Beverage'.tr(context)),
                const TextSpan(text: ':'),
                TextSpan(text: historyModel.beverageType),
              ],
              style: context.textStyleTheme.b12Medium.copyWith(color: context.colorTheme.neutral.shade6),
            ),
          ),
        if (isMemoNotEmpty)
          Text(
            historyModel.memo!,
            style: context.textStyleTheme.b12Medium.copyWith(color: context.colorTheme.neutral.shade6),
          ),
      ],
    );
  }
}

class _DetailedListVoidingHistoryWidget extends DetailedListHistoryWidget {
  const _DetailedListVoidingHistoryWidget({
    required super.key,
    required super.onTapEdit,
    required super.onTapDelete,
    required DetailedListVoidingHistoryModel super.historyModel,
  }) : super._();

  @override
  DetailedListVoidingHistoryModel get historyModel => super.historyModel as DetailedListVoidingHistoryModel;

  @override
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        _buildHistoryType(context, type: 'Voiding'.tr(context)),
        if (historyModel.isNocutria) ...[
          const Gap(8),
          Container(
            alignment: Alignment.center,
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorTheme.neutral.shade2,
            ),
            child: Assets.icon.icDiaryNighttime.svg(),
          ),
        ],
      ],
    );
  }

  @override
  Widget _buildBody(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: List.generate(
          historyModel.leakageVolume == null ? 3 : 5,
          (index) {
            if (index.isOdd) return const Gap(8);
            final realIndex = index ~/ 2;

            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: switch (realIndex) {
                        0 => [
                            TextSpan(text: 'Volume'.tr(context)),
                            const TextSpan(text: ' '),
                            // TextSpan(
                            //   text: '(${context.unitName})'.tr(context),
                            //   style: TextStyle(color: context.colorTheme.neutral.shade6),
                            // ),
                          ],
                        1 => [TextSpan(text: 'Urge Lv'.tr(context))],
                        2 when historyModel.leakageVolume != null => [TextSpan(text: 'Leakage'.tr(context))],
                        _ => const [],
                      },
                      style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
                    ),
                  ),
                  const Gap(8),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _getColor(context),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Text(
                      switch (realIndex) {
                        0 => '${historyModel.recordVolume == 0 ? 'N/A' : context.unitValue(historyModel.recordVolume)}',
                        1 => 'Lv ${historyModel.recordUrgency}',
                        2 when historyModel.leakageVolume != null => historyModel.leakageVolume!.tr(context),
                        _ => '',
                      },
                      style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade1),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Color _getColor(BuildContext context) => context.colorTheme.vermilion.primary.shade50;
}

class _DetailedListLeakageHistoryWidget extends DetailedListHistoryWidget {
  const _DetailedListLeakageHistoryWidget({
    required super.key,
    required super.onTapEdit,
    required super.onTapDelete,
    required DetailedListLeakageHistoryModel super.historyModel,
  }) : super._();

  @override
  DetailedListLeakageHistoryModel get historyModel => super.historyModel as DetailedListLeakageHistoryModel;

  @override
  Widget _buildHeader(BuildContext context) {
    return _buildHistoryType(context, type: 'Leakage'.tr(context));
  }

  @override
  Widget _buildBody(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total amount'.tr(context),
                style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
              ),
              const Gap(8),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _getColor(context),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  historyModel.leakageVolume.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade1),
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        const Spacer(),
      ],
    );
  }

  @override
  Color _getColor(BuildContext context) => const Color(0xFF606AC9);
}

class _DetailedListIntakeHistoryWidget extends DetailedListHistoryWidget {
  const _DetailedListIntakeHistoryWidget({
    required super.key,
    required super.onTapEdit,
    required super.onTapDelete,
    required DetailedListIntakeHistoryModel super.historyModel,
  }) : super._();

  @override
  DetailedListIntakeHistoryModel get historyModel => super.historyModel as DetailedListIntakeHistoryModel;

  @override
  Widget _buildHeader(BuildContext context) {
    return _buildHistoryType(context, type: 'Intake'.tr(context));
  }

  @override
  Widget _buildBody(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total amount'.tr(context),
                style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
              ),
              const Gap(8),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _getColor(context),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  '${historyModel.recordVolume}',
                  style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade1),
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Beverage type'.tr(context),
                style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
              ),
              const Gap(8),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _getColor(context),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(minWidth: 54),
                      child: Text(
                        BeverageTypeModel.of(historyModel.beverageType).name.tr(context),
                        style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade1),
                      ),
                    ),
                    const Gap(8),
                    historyModel.icon.svg(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Color _getColor(BuildContext context) => context.colorTheme.paleLime.shade70;
}
