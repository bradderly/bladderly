import 'package:bradderly/domain/model/sex.dart';
import 'package:bradderly/domain/model/user.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.gender,
    required this.yearOfBirth,
  });

  factory UserModel.fromDomain(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      gender: Gender.values.byName(user.gender),
      yearOfBirth: user.yearOfBirth,
    );
  }

  final String id;
  final Gender gender;
  final int yearOfBirth;
  final String? name;
  final String? email;

  @override
  List<Object?> get props => [
        id,
        gender,
        yearOfBirth,
        name,
        email,
      ];
}
