import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:rxdart/rxdart.dart';

part 'src/recorder.dart';
part 'src/recorder_impl.dart';

@module
abstract class RecorderModule {
  @factoryMethod
  Recorder get recorder => _RecorderImpl(recorder: AudioRecorder());
}
