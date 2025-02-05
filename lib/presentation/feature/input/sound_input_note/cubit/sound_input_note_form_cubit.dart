import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sound_input_note_form_state.dart';

class SoundInputNoteFormCubit extends Cubit<SoundInputNoteFormState> {
  SoundInputNoteFormCubit() : super(const SoundInputNoteFormState());

  void setLevel(int level) {
    emit(state.copyWith(recordUrgency: level));
  }

  void setIsNocutria(bool isNocutria) {
    emit(state.copyWith(isNocutria: isNocutria));
  }

  void setIsLeakage(bool isLeakage) {
    emit(state.copyWith(isLeakage: isLeakage));
  }

  void setMemo(String memo) {
    emit(state.copyWith(memo: memo));
  }
}
