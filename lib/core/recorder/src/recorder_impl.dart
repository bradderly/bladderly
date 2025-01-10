part of '../recorder_module.dart';

class _RecorderImpl extends Recorder {
  _RecorderImpl({required this.recorder}) : super() {
    recorder.onStateChanged().listen((state) => _subject.add(RecorderState.values.byName(state.name)));
  }

  final AudioRecorder recorder;
  late final _subject = BehaviorSubject<RecorderState>.seeded(RecorderState.idle);

  Future<Directory> _getDirectory() {
    return getApplicationDocumentsDirectory()
        .then((directory) => directory.path)
        .then((path) => Directory('$path/sound'))
        .then((directory) => directory.existsSync() ? directory : (directory..createSync()));
  }

  @override
  Future<bool> chekcPermission() {
    return recorder.hasPermission();
  }

  @override
  Stream<RecorderState> onStateChanged() {
    return _subject.stream;
  }

  @override
  Future<void> start({
    required String fileName,
    Duration maxDuration = const Duration(minutes: 3),
  }) async {
    final filePath = await getFile(fileName).then((file) => file.path);

    return recorder.start(
      RecordConfig(bitRate: Platform.isAndroid ? 64000 : 128000),
      path: filePath,
    );
  }

  @override
  Future<void> stop() {
    return recorder.stop();
  }

  @override
  Future<void> dispose() {
    return recorder.dispose();
  }

  @override
  RecorderState get state => _subject.value;

  @override
  Future<File> getFile(String fileName) {
    return _getDirectory().then((directory) => File(join(directory.path, fileName)));
  }
}
