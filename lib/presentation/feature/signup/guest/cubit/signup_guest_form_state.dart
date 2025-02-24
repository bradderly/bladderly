part of 'signup_guest_form_cubit.dart';

class SignupGuestFormState extends Equatable {
  const SignupGuestFormState({
    this.sex,
    String yearOfBirth = '',
  }) : _yearOfBirth = yearOfBirth;

  final Sex? sex;
  final String _yearOfBirth;

  bool get isValid {
    if (sex == null) return false;

    final yearOfBirth = int.tryParse(_yearOfBirth) ?? 0;

    if (yearOfBirth < 1900 || yearOfBirth > DateTime.now().year) return false;

    return true;
  }

  int get yearOfBirth => int.parse(_yearOfBirth);

  SignupGuestFormState copyWith({
    Sex? sex,
    String? yearOfBirth,
  }) {
    return SignupGuestFormState(
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
