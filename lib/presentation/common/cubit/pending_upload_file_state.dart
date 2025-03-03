part of 'pending_upload_file_cubit.dart';

class PendingUploadFileState extends Equatable {
  const PendingUploadFileState({
    this.recordTime,
  });

  final DateTime? recordTime;

  @override
  List<Object?> get props => [
        recordTime,
      ];
}
