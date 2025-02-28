import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.gender,
    required this.yearOfBirth,
    required this.signUpMethod,
    this.email,
    this.name,
    this.disease,
  });

  final String id;

  final Gender gender;

  final int yearOfBirth;

  final SignUpMethod signUpMethod;

  final String? name;

  final String? email;

  final String? disease;

  User copyWith({
    Gender? gender,
    int? yearOfBirth,
    SignUpMethod? signUpMethod,
    String? name,
    String? email,
    String? disease,
  }) {
    return User(
      id: id,
      gender: gender ?? this.gender,
      yearOfBirth: yearOfBirth ?? this.yearOfBirth,
      signUpMethod: signUpMethod ?? this.signUpMethod,
      name: name ?? this.name,
      email: email ?? this.email,
      disease: disease ?? this.disease,
    );
  }

  @override
  List<Object?> get props => [
        id,
        gender,
        yearOfBirth,
        signUpMethod,
        name,
        email,
        disease,
      ];
}
