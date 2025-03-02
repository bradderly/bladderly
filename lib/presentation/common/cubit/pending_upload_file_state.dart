part of 'pending_upload_file_cubit.dart';

class PendingUploadFileState extends Equatable {
  const PendingUploadFileState({
    this.recorderFile,
  });

  final DateTime? recorderFile;

  @override
  List<Object?> get props => [
        recorderFile,
      ];
}
