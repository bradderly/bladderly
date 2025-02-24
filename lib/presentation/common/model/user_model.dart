import 'package:bradderly/domain/model/user.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthYear,
    required this.height,
    required this.weight,
    required this.email,
  });

  const UserModel.none()
      : id = '',
        firstName = '',
        lastName = '',
        gender = '',
        birthYear = 0,
        height = 0,
        weight = 0,
        email = '';

  factory UserModel.fromDomain(User user) {
    return const UserModel.none();
  }

  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final int birthYear;
  final int height;
  final int weight;
  final String email;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        gender,
        birthYear,
        height,
        weight,
        email,
      ];
}
