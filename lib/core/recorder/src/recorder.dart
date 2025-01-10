part of '../recorder_module.dart';

enum RecorderState { idle, pause, record, stop }

abstract class Recorder {
  const Recorder();

  /// 음성 녹음 권한 체크
  Future<bool> chekcPermission();

  Future<void> start({
    required String fileName,
    Duration maxDuration = const Duration(minutes: 3),
  });

  Future<void> stop();

  Stream<RecorderState> onStateChanged();

  Future<void> dispose();

  RecorderState get state;

  Future<File> getFile(String fileName);
}
