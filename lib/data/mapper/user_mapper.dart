import 'package:bradderly/data/isar/schema/user_entity.dart';
import 'package:bradderly/domain/model/user.dart';

class UserMapper {
  const UserMapper._();

  static User fromUserEntity(UserEntity entity) {
    return User(
      id: entity.userId,
      email: entity.email,
      gender: entity.gender,
      name: entity.name,
      signupMethod: entity.signupMethod,
      yearOfBirth: entity.yearOfBirth,
    );
  }
}
