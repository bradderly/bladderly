part of 'sound_input_note_form_cubit.dart';

class SoundInputNoteFormState extends Equatable {
  const SoundInputNoteFormState({
    this.recordUrgency,
    this.isNocutria,
    this.isLeakage,
    this.leakageVolume,
    this.memo = '',
  });

  final int? recordUrgency;
  final bool? isNocutria;
  final bool? isLeakage;
  final LeakageVolume? leakageVolume;
  final String memo;

  bool get isValid => recordUrgency != null && isNocutria != null && isLeakage != null && _isLeakageVolumeValid;

  bool get _isLeakageVolumeValid {
    if (isLeakage == false) return true;
    if (isLeakage == true && leakageVolume != null) return true;

    return false;
  }

  SoundInputNoteFormState copyWith({
    int? recordUrgency,
    bool? isNocutria,
    bool? isLeakage,
    LeakageVolume? leakageVolume,
    String? memo,
  }) {
    return SoundInputNoteFormState(
      recordUrgency: recordUrgency ?? this.recordUrgency,
      isNocutria: isNocutria ?? this.isNocutria,
      isLeakage: isLeakage ?? this.isLeakage,
      leakageVolume: leakageVolume ?? this.leakageVolume,
      memo: memo ?? this.memo,
    );
  }

  @override
  List<Object?> get props => [
        recordUrgency,
        isNocutria,
        isLeakage,
        leakageVolume,
        memo,
      ];
}
