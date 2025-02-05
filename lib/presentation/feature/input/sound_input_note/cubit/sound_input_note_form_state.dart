part of 'sound_input_note_form_cubit.dart';

class SoundInputNoteFormState extends Equatable {
  const SoundInputNoteFormState({
    this.recordUrgency,
    this.isNocutria,
    this.isLeakage,
    this.memo = '',
  });

  final int? recordUrgency;
  final bool? isNocutria;
  final bool? isLeakage;
  final String memo;

  bool get isValid => recordUrgency != null && isNocutria != null && isLeakage != null;

  SoundInputNoteFormState copyWith({
    int? recordUrgency,
    bool? isNocutria,
    bool? isLeakage,
    String? memo,
  }) {
    return SoundInputNoteFormState(
      recordUrgency: recordUrgency ?? this.recordUrgency,
      isNocutria: isNocutria ?? this.isNocutria,
      isLeakage: isLeakage ?? this.isLeakage,
      memo: memo ?? this.memo,
    );
  }

  @override
  List<Object?> get props => [
        recordUrgency,
        isNocutria,
        isLeakage,
        memo,
      ];
}
