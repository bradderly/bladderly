import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/domain/usecase/delete_history_usecase.dart';
import 'package:bradderly/domain/usecase/get_histories_stream_usecase.dart';
import 'package:bradderly/presentation/feature/diary/detailed_list/bloc/detailed_list_histories_bloc.dart';
import 'package:bradderly/presentation/feature/diary/detailed_list/detailed_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedListBuilder extends StatelessWidget {
  const DetailedListBuilder({
    super.key,
    required this.date,
    required this.historyId,
  });

  final DateTime date;
  final int historyId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailedListHistoriesBloc>(
      create: (_) => DetailedListHistoriesBloc(
        getHistoriesStreamUsecase: getIt<GetHistoriesStreamUsecase>(),
        deleteHistoryUsecase: getIt<DeleteHistoryUsecase>(),
      )..add(DetailedListHistoriesSubscribe(hashId: 'ydu3328@naver.com', dateTime: date)),
      child: DetailedListView(
        historyId: historyId,
        date: date,
      ),
    );
  }
}
