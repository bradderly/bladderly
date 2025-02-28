import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/diary/detailed_list/model/detailed_list_history_model.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
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
          const Divider(color: Color(0xFFE6E6E6), thickness: 1, height: 35),
          _buildBody(context),
          if (historyModel.memo case final String memo when memo.trim().isNotEmpty) ...[
            const Gap(16),
            Text(
              memo,
              style: context.textStyleTheme.b12Medium.copyWith(color: context.colorTheme.neutral.shade6),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context);

  Widget _buildBody(BuildContext context);

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

  Color _getColor(BuildContext context);
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
                            TextSpan(
                              text: '(${context.unitName})'.tr(context),
                              style: TextStyle(color: context.colorTheme.neutral.shade6),
                            ),
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
                        0 => '${context.unitValue(historyModel.recordVolume)}',
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
                        historyModel.beverageType.tr(context),
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
