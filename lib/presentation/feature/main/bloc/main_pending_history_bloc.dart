// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/domain/usecase/upload_pending_upload_histories_usecase.dart';

part 'main_pending_history_event.dart';
part 'main_pending_history_state.dart';

class MainPendingHistoryBloc extends Bloc<MainPendingHistoryEvent, MainPendingHistoryState> {
  MainPendingHistoryBloc({
    required UploadPendingHistoriesUsecase uploadPendingHistoriesUsecase,
  })  : _uploadPendingHistoriesUsecase = uploadPendingHistoriesUsecase,
        super(const MainPendingHistoryInitial()) {
    on<MainPendingHistoryUpload>(_onUpload, transformer: droppable());
  }

  final UploadPendingHistoriesUsecase _uploadPendingHistoriesUsecase;

  Future<void> _onUpload(MainPendingHistoryUpload event, Emitter<MainPendingHistoryState> emit) async {
    emit(const MainPendingHistoryUploadInProgress());

    final result = await _uploadPendingHistoriesUsecase(userId: event.userId);

    result.fold(
      (exception) => emit(MainPendingHistoryUploadFailure(exception: exception)),
      (_) => emit(const MainPendingHistoryUploadSuccess()),
    );
  }
}
