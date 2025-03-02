// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/feature/diary/detailed_list/bloc/detailed_list_histories_bloc.dart';
import 'package:bladderly/presentation/feature/diary/detailed_list/modal/detailed_list_delete_history_modal.dart';
import 'package:bladderly/presentation/feature/diary/detailed_list/model/detailed_list_history_model.dart';
import 'package:bladderly/presentation/feature/diary/detailed_list/widget/detailed_list_histories_widget.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';

class DetailedListView extends StatefulWidget {
  const DetailedListView({
    super.key,
    required this.date,
    required this.historyId,
  });

  final DateTime date;
  final int historyId;

  @override
  State<DetailedListView> createState() => _DetailedListViewState();
}

class _DetailedListViewState extends State<DetailedListView> {
  List<GlobalObjectKey> historyKeys = [];

  @override
  void initState() {
    super.initState();
  }

  void _onHistoiresLoadSuccess(BuildContext context, DetailedListHistoriesLoadSuccess state) {
    final historyKeys = this.historyKeys.toList();
    GlobalObjectKey? scrollTargetKey;

    for (final historyId in state.groupedHistoriesModel.historyIds) {
      final containsKey = historyKeys.firstWhereOrNull((element) => element.value == historyId) != null;

      if (containsKey) continue;

      final historyKey = GlobalObjectKey(historyId);

      if (widget.historyId == historyId) {
        scrollTargetKey = historyKey;
      }

      historyKeys.add(historyKey);
    }

    if (context.mounted && historyKeys.length != this.historyKeys.length) {
      setState(() => this.historyKeys = historyKeys);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollTargetKey?.currentContext case final BuildContext context when context.mounted) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailedListHistoriesBloc, DetailedListHistoriesState>(
      listener: (context, state) => switch (state) {
        DetailedListHistoriesLoadSuccess() => _onHistoiresLoadSuccess(context, state),
        _ => null,
      },
      child: Scaffold(
        backgroundColor: context.colorTheme.neutral.shade2,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          toolbarHeight: 90,
          backgroundColor: context.colorTheme.neutral.shade2,
          title: Padding(
            padding: const EdgeInsets.only(top: 34),
            child: Text(
              switch (context.locale) {
                AppLocale.en => DateFormat('EEEE, M d, yyyy').format(widget.date),
                AppLocale.ko => DateFormat('yyyy년 M월 d일 EEEE', context.locale.name).format(widget.date),
              },
              style: context.textStyleTheme.b20Bold.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 34),
              child: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Assets.icon.icExportClose.svg(
                  colorFilter: ColorFilter.mode(
                    context.colorTheme.neutral.shade8,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const Gap(16),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<DetailedListHistoriesBloc, DetailedListHistoriesState>(
            builder: (context, state) => ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 32),
              itemCount: state.groupedHistoriesModel.keyCount,
              itemBuilder: (context, index) {
                final groupedHistories = state.groupedHistoriesModel.groupedHistories;

                return DetailedListHistoriesWidget(
                  onTapEdit: (id) =>
                      switch (groupedHistories.values.flattened.firstWhere((element) => element.id == id)) {
                    final DetailedListVoidingHistoryModel historyModel =>
                      ManualInputRoute(historyId: historyModel.id).push<void>(context),
                    final DetailedListLeakageHistoryModel historyModel =>
                      ManualInputRoute(historyId: historyModel.id).push<void>(context),
                    final DetailedListIntakeHistoryModel historyModel =>
                      IntakeInputRoute.fromHistoryId(historyId: historyModel.id).push<void>(context),
                  },
                  onTapDelete: (id) => DetailedListDeleteHistoryModal.show(context).then((value) {
                    if (value && context.mounted) {
                      context.read<DetailedListHistoriesBloc>().add(DetailedListHistoriesDelete(id: id));
                    }
                  }),
                  recordTime: groupedHistories.keys.elementAt(index),
                  historyKeys: historyKeys,
                  histories: groupedHistories.values.elementAt(index),
                );
              },
              separatorBuilder: (context, index) => Container(
                padding: const EdgeInsets.symmetric(vertical: 16).copyWith(left: 54),
                alignment: Alignment.center,
                child: Text(
                  state.groupedHistoriesModel.getInterval(context, index: index),
                  style: context.textStyleTheme.b12Medium.copyWith(
                    color: context.colorTheme.neutral.shade10,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
