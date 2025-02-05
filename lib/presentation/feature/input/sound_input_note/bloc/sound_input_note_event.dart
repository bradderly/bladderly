part of 'sound_input_note_bloc.dart';

sealed class SoundInputNoteEvent extends Equatable {
  const SoundInputNoteEvent();

  @override
  List<Object> get props => [];
}

class SoundInputNoteUpload extends SoundInputNoteEvent {
  const SoundInputNoteUpload({
    required this.hashId,
    required this.file,
    required this.recordTime,
    required this.recordUrgency,
    required this.isNocutria,
    required this.isLeakage,
    required this.memo,
  });

  final String hashId;
  final File file;
  final DateTime recordTime;
  final int recordUrgency;
  final bool isNocutria;
  final bool isLeakage;
  final String memo;

  @override
  List<Object> get props => [
        file,
        recordTime,
        recordUrgency,
        isNocutria,
        isLeakage,
        memo,
      ];
}
