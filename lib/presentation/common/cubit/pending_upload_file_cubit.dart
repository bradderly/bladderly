// Package imports:
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'pending_upload_file_state.dart';

class PendingUploadFileCubit extends HydratedCubit<PendingUploadFileState> {
  PendingUploadFileCubit() : super(const PendingUploadFileState());

  final _recordTimeKey = 'record_time';

  void setRecordTime(DateTime recordTime) {
    emit(PendingUploadFileState(recordTime: recordTime));
  }

  void clearRecordTime() {
    emit(const PendingUploadFileState());
  }

  @override
  PendingUploadFileState? fromJson(Map<String, dynamic> json) {
    final recordTime = switch (json[_recordTimeKey]) {
      final int recordTime => DateTime.fromMillisecondsSinceEpoch(recordTime),
      _ => null,
    };

    return PendingUploadFileState(recordTime: recordTime);
  }

  @override
  Map<String, dynamic>? toJson(PendingUploadFileState state) {
    return {
      _recordTimeKey: state.recordTime?.millisecondsSinceEpoch,
    };
  }
}
