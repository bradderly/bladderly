import 'dart:io';

import 'package:bladderly/domain/usecase/save_voiding_history_with_file_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sound_input_note_event.dart';
part 'sound_input_note_state.dart';

class SoundInputNoteBloc extends Bloc<SoundInputNoteEvent, SoundInputNoteState> {
  SoundInputNoteBloc({
    required SaveVoidingHistoryWithFileUsecase saveVoidingHistoryWithFileUsecase,
  })  : _saveVoidingHistoryWithFileUsecase = saveVoidingHistoryWithFileUsecase,
        super(const SoundInputNoteInitial()) {
    on<SoundInputNoteUpload>(_onUpload, transformer: droppable());
  }

  final SaveVoidingHistoryWithFileUsecase _saveVoidingHistoryWithFileUsecase;

  Future<void> _onUpload(SoundInputNoteUpload event, Emitter<SoundInputNoteState> emit) async {
    emit(const SoundInputUploadInProgress());

    final result = await _saveVoidingHistoryWithFileUsecase(
      hashId: event.hashId,
      file: event.file,
      recordTime: event.recordTime,
      recordUrgency: event.recordUrgency,
      isLeakage: event.isLeakage,
      isNocutria: event.isNocutria,
    );

    result.fold(
      (exception) => emit(SoundInputUploadFailure(error: exception)),
      (_) => emit(const SoundInputUploadSuccess()),
    );
  }
}
