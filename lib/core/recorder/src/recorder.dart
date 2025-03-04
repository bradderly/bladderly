part of '../recorder_module.dart';

sealed class RecorderState extends Equatable {
  const RecorderState({
    required this.recordTime,
  });

  final DateTime? recordTime;

  @override
  List<Object?> get props => [
        recordTime,
      ];
}

class RecorderIdle extends RecorderState {
  const RecorderIdle() : super(recordTime: null);
}

class RecorderReady extends RecorderState {
  const RecorderReady({
    required DateTime super.recordTime,
  });

  @override
  DateTime get recordTime => super.recordTime!;
}

class RecorderRecording extends RecorderState {
  const RecorderRecording({
    required DateTime super.recordTime,
  });

  @override
  DateTime get recordTime => super.recordTime!;
}

class RecorderPaused extends RecorderState {
  const RecorderPaused({
    required DateTime super.recordTime,
  });

  @override
  DateTime get recordTime => super.recordTime!;
}

class RecorderStopped extends RecorderState {
  const RecorderStopped({
    required DateTime super.recordTime,
  });

  @override
  DateTime get recordTime => super.recordTime!;
}

abstract class RecorderFileLoader {
  const RecorderFileLoader();

  File getFile(DateTime recordTime);
}

/// 레코더 인스턴스는 1회만 녹음이 가능하다.
abstract class Recorder {
  const Recorder();

  /// 음성 녹음 권한 체크
  Future<bool> chekcPermission();

  Future<void> start({required DateTime recordTime});

  Future<DateTime> stop();

  Stream<RecorderState> onStateChanged();

  Future<void> dispose();

  RecorderState get state;

  File getFile(DateTime recordTime);

  void delete(DateTime recordTime);
}
