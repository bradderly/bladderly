// Dart imports:
import 'dart:io';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:rxdart/rxdart.dart';

part 'src/recorder.dart';
part 'src/recorder_impl.dart';

@module
abstract class RecorderModule {
  @factoryMethod
  Recorder getRecorder(
    AudioRecorder recorder,
    Directory directory,
  ) {
    return _RecorderImpl(recorder: recorder, directory: directory);
  }

  @lazySingleton
  RecorderFileLoader getRecorderFileLoader(
    AudioRecorder recorder,
    Directory directory,
  ) {
    return _RecorderImpl(recorder: recorder, directory: directory);
  }

  @factoryMethod
  AudioRecorder getAudioRecorder() {
    return AudioRecorder();
  }

  @lazySingleton
  @preResolve
  Future<Directory> get directory {
    return getApplicationDocumentsDirectory()
        .then((directory) => directory.path)
        .then((path) => Directory(join(path, 'sound')))
        .then((directory) => directory.existsSync() ? directory : (directory..createSync()));
  }
}
