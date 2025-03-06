// Package imports:
// Project imports:
import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.gender,
    required this.yearOfBirth,
  });

  factory UserModel.fromDomain(User user) {
    if (user.signUpMethod == SignUpMethod.N) {
      return GuestUserModel(
        id: user.id,
        gender: user.gender,
        yearOfBirth: user.yearOfBirth,
      );
    }

    return RegularUserModel(
      id: user.id,
      gender: user.gender,
      yearOfBirth: user.yearOfBirth,
      name: user.name ?? 'Bladderly User',
      disease: user.disease ?? '',
      email: user.email!,
    );
  }

  final String id;

  final Gender gender;

  final int yearOfBirth;

  @override
  List<Object?> get props => [
        id,
        gender,
        yearOfBirth,
      ];
}

class GuestUserModel extends UserModel {
  const GuestUserModel({
    required super.id,
    required super.gender,
    required super.yearOfBirth,
  });
}

class RegularUserModel extends UserModel {
  const RegularUserModel({
    required super.id,
    required super.gender,
    required super.yearOfBirth,
    required this.name,
    required this.email,
    required this.disease,
  });

  final String name;

  final String email;

  final String disease;

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        email,
        disease,
      ];
}
