import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/domain/usecase/delete_history_usecase.dart';
import 'package:bradderly/domain/usecase/get_histories_stream_usecase.dart';
import 'package:bradderly/presentation/feature/diary/detailed_list/model/detailed_list_grouped_histories_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detailed_list_histories_event.dart';
part 'detailed_list_histories_state.dart';

class DetailedListHistoriesBloc extends Bloc<DetailedListHistoriesEvent, DetailedListHistoriesState> {
  DetailedListHistoriesBloc({
    required GetHistoriesStreamUsecase getHistoriesStreamUsecase,
    required DeleteHistoryUsecase deleteHistoryUsecase,
  })  : _getHistoriesStreamUsecase = getHistoriesStreamUsecase,
        _deleteHistoryUsecase = deleteHistoryUsecase,
        super(const DetailedListHistoriesInitial()) {
    on<DetailedListHistoriesSubscribe>(_onSubscribe);
    on<DetailedListHistoriesDelete>(_onDelete);
  }

  final GetHistoriesStreamUsecase _getHistoriesStreamUsecase;
  final DeleteHistoryUsecase _deleteHistoryUsecase;

  Future<void> _onSubscribe(DetailedListHistoriesSubscribe event, Emitter<DetailedListHistoriesState> emit) {
    return _getHistoriesStreamUsecase(userId: event.userId, dateTime: DateUtils.dateOnly(event.dateTime)).fold(
      (l) => Future.sync(
        () => emit(
          DetailedListHistoriesSubscribeFailure(
            groupedHistoriesModel: state.groupedHistoriesModel,
            exception: l,
          ),
        ),
      ),
      (r) {
        emit(DetailedListHistoriesSubscribeSuccess(groupedHistoriesModel: state.groupedHistoriesModel));

        return emit.forEach<Histories>(
          r,
          onData: (data) => DetailedListHistoriesLoadSuccess(
            groupedHistoriesModel: DetailedListGroupedHistoriesModel.fromHistoies(data),
          ),
          onError: (error, stackTrace) => DetailedListHistoriesLoadFailure(
            groupedHistoriesModel: state.groupedHistoriesModel,
            exception: error as Exception,
          ),
        );
      },
    );
  }

  void _onDelete(DetailedListHistoriesDelete event, Emitter<DetailedListHistoriesState> emit) {
    emit(DetailedListHistoriesDeleteInProgress(groupedHistoriesModel: state.groupedHistoriesModel));

    _deleteHistoryUsecase(historyId: event.id).fold(
      (l) => emit(DetailedListHistoriesDeleteFailure(groupedHistoriesModel: state.groupedHistoriesModel, exception: l)),
      (r) => emit(DetailedListHistoriesDeleteSuccess(groupedHistoriesModel: state.groupedHistoriesModel)),
    );
  }
}
