part of 'sound_input_note_bloc.dart';

sealed class SoundInputNoteState extends Equatable {
  const SoundInputNoteState();

  @override
  List<Object> get props => [];
}

final class SoundInputNoteInitial extends SoundInputNoteState {
  const SoundInputNoteInitial();
}

final class SoundInputUploadInProgress extends SoundInputNoteState {
  const SoundInputUploadInProgress();
}

final class SoundInputUploadSuccess extends SoundInputNoteState {
  const SoundInputUploadSuccess({
    required this.historyId,
  });

  final int historyId;

  @override
  List<Object> get props => [
        ...super.props,
        historyId,
      ];
}

final class SoundInputUploadFailure extends SoundInputNoteState {
  const SoundInputUploadFailure({
    required this.error,
  });

  final Exception error;

  @override
  List<Object> get props => [
        error,
      ];
}
