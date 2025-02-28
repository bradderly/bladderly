import 'package:bladderly/core/recorder/src/recorder_file.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'pending_upload_file_state.dart';

class PendingUploadFileCubit extends HydratedCubit<PendingUploadFileState> {
  PendingUploadFileCubit() : super(const PendingUploadFileState());

  void setFileName(RecorderFile recorderFile) {
    emit(PendingUploadFileState(recorderFile: recorderFile));
  }

  void clearFileName() {
    emit(const PendingUploadFileState());
  }

  @override
  PendingUploadFileState? fromJson(Map<String, dynamic> json) {
    if (json['recorder_file_name'] case final String fileName) {
      return PendingUploadFileState(recorderFile: RecorderFile(name: fileName));
    }

    return null;
  }

  @override
  Map<String, dynamic>? toJson(PendingUploadFileState state) {
    if (state.recorderFile?.name case final String fileName) return {'recorder_file_name': fileName};

    return null;
  }
}
