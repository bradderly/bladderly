part of 'sign_up_required_info_form_cubit.dart';

class SignUpRequiredInfoFormState extends Equatable {
  const SignUpRequiredInfoFormState({
    this.gender,
    String yearOfBirth = '',
  }) : _yearOfBirth = yearOfBirth;

  final Gender? gender;
  final String _yearOfBirth;

  bool get isValid {
    if (gender == null) return false;

    final yearOfBirth = int.tryParse(_yearOfBirth) ?? 0;

    if (yearOfBirth < 1900 || yearOfBirth > DateTime.now().year) return false;

    return true;
  }

  int get yearOfBirth => int.parse(_yearOfBirth);

  SignUpRequiredInfoFormState copyWith({
    Gender? gender,
    String? yearOfBirth,
  }) {
    return SignUpRequiredInfoFormState(
      gender: gender ?? this.gender,
      yearOfBirth: yearOfBirth ?? _yearOfBirth,
    );
  }

  @override
  List<Object?> get props => [
        gender,
        _yearOfBirth,
      ];
}
