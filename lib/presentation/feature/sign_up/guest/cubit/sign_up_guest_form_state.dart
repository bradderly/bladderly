part of 'sign_up_guest_form_cubit.dart';

class SignUpGuestFormState extends Equatable {
  const SignUpGuestFormState({
    this.sex,
    String yearOfBirth = '',
  }) : _yearOfBirth = yearOfBirth;

  final Gender? sex;
  final String _yearOfBirth;

  bool get isValid {
    if (sex == null) return false;

    final yearOfBirth = int.tryParse(_yearOfBirth) ?? 0;

    if (yearOfBirth < 1900 || yearOfBirth > DateTime.now().year) return false;

    return true;
  }

  int get yearOfBirth => int.parse(_yearOfBirth);

  SignUpGuestFormState copyWith({
    Gender? sex,
    String? yearOfBirth,
  }) {
    return SignUpGuestFormState(
      sex: sex ?? this.sex,
      yearOfBirth: yearOfBirth ?? _yearOfBirth,
    );
  }

  @override
  List<Object?> get props => [
        sex,
        _yearOfBirth,
      ];
}
