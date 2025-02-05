part of '../recorder_module.dart';

class _RecorderImpl extends Recorder {
  _RecorderImpl({
    required AudioRecorder recorder,
    required Directory directory,
  })  : _recorder = recorder,
        _directory = directory,
        super() {
    _recorder.onStateChanged().listen(
          (state) => _subject.add(
            switch (state) {
              RecordState.record => RecorderRecording(file: _subject.value.file!),
              RecordState.stop => RecorderStopped(file: _subject.value.file!),
              RecordState.pause => RecorderPaused(file: _subject.value.file!),
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
  Future<void> start({required String fileName}) async {
    if (state is RecorderRecording || state is RecorderPaused) throw Exception('이미 녹음 중입니다.');

    final filePath = join(_directory.path, fileName);

    _subject.add(RecorderReady(file: RecorderFile(name: fileName)));

    return _recorder.start(
      RecordConfig(bitRate: Platform.isAndroid ? 64000 : 128000, numChannels: 1),
      path: filePath,
    );
  }

  @override
  Future<RecorderFile> stop() {
    final state = _subject.value;

    if (state is! RecorderRecording) throw Exception('녹음 중이 아닙니다.');

    return _recorder.stop().then((_) => state.file);
  }

  @override
  Future<void> dispose() {
    return _recorder.dispose();
  }

  @override
  RecorderState get state => _subject.value;

  @override
  bool exist(RecorderFile file) => getFile(file).existsSync();

  @override
  File getFile(RecorderFile file) => File(join(_directory.path, file.name));

  @override
  void delete(RecorderFile file) {
    if (exist(file)) {
      getFile(file).deleteSync();
    }
  }
}
