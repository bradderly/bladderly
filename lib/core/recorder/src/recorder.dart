part of '../recorder_module.dart';

sealed class RecorderState extends Equatable {
  const RecorderState({
    required this.file,
  });

  final RecorderFile? file;

  @override
  List<Object?> get props => [
        file,
      ];
}

class RecorderIdle extends RecorderState {
  const RecorderIdle() : super(file: null);
}

class RecorderReady extends RecorderState {
  const RecorderReady({
    required RecorderFile super.file,
  });

  @override
  RecorderFile get file => super.file!;
}

class RecorderRecording extends RecorderState {
  const RecorderRecording({
    required RecorderFile super.file,
  });

  @override
  RecorderFile get file => super.file!;
}

class RecorderPaused extends RecorderState {
  const RecorderPaused({
    required RecorderFile super.file,
  });

  @override
  RecorderFile get file => super.file!;
}

class RecorderStopped extends RecorderState {
  const RecorderStopped({
    required RecorderFile super.file,
  });

  @override
  RecorderFile get file => super.file!;
}

/// 레코더 인스턴스는 1회만 녹음이 가능하다.
abstract class Recorder {
  const Recorder();

  /// 음성 녹음 권한 체크
  Future<bool> chekcPermission();

  Future<void> start({required String fileName});

  Future<RecorderFile> stop();

  Stream<RecorderState> onStateChanged();

  Future<void> dispose();

  RecorderState get state;

  bool exist(RecorderFile file);

  File getFile(RecorderFile file);

  void delete(RecorderFile file);
}
