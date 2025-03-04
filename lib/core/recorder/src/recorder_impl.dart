part of '../recorder_module.dart';

class _RecorderImpl implements Recorder, RecorderFileLoader {
  _RecorderImpl({
    required AudioRecorder recorder,
    required Directory directory,
  })  : _recorder = recorder,
        _directory = directory,
        super() {
    _recorder.onStateChanged().listen(
          (state) => _subject.add(
            switch (state) {
              RecordState.record => RecorderRecording(recordTime: _subject.value.recordTime!),
              RecordState.stop => RecorderStopped(recordTime: _subject.value.recordTime!),
              RecordState.pause => RecorderPaused(recordTime: _subject.value.recordTime!),
            },
          ),
        );
  }

  final AudioRecorder _recorder;
  final Directory _directory;
  final _subject = BehaviorSubject<RecorderState>.seeded(const RecorderIdle());

  @override
  Future<bool> chekcPermission() {
    return _recorder.hasPermission();
  }

  @override
  Stream<RecorderState> onStateChanged() {
    return _subject.stream;
  }

  @override
  Future<void> start({required DateTime recordTime}) async {
    if (state is RecorderRecording || state is RecorderPaused) throw Exception('이미 녹음 중입니다.');

    final filePath = getFile(recordTime).path;

    _subject.add(RecorderReady(recordTime: recordTime));

    return _recorder.start(
      RecordConfig(bitRate: Platform.isAndroid ? 64000 : 128000, numChannels: 1),
      path: filePath,
    );
  }

  @override
  Future<DateTime> stop() {
    final state = _subject.value;

    if (state is! RecorderRecording) throw Exception('녹음 중이 아닙니다.');

    return _recorder.stop().then((_) => state.recordTime);
  }

  @override
  Future<void> dispose() {
    return _recorder.dispose();
  }

  @override
  RecorderState get state => _subject.value;

  @override
  File getFile(DateTime recordTime) =>
      File(join(_directory.path, '${DateFormat('yyyyMMdd-HHmmss').format(recordTime)}.m4a'));

  @override
  void delete(DateTime recordTime) {
    if (getFile(recordTime) case final File file) file.deleteSync();
  }
}
