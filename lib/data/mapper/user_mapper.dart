// Project imports:
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/schema/user_entity.dart';
import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/model/user.dart';

class UserMapper {
  const UserMapper._();

  static User fromUserEntity(UserEntity entity) {
    return User(
      id: entity.userId,
      email: entity.email,
      gender: Gender.values.byName(entity.gender),
      name: entity.name,
      signUpMethod: SignUpMethod.of(entity.signUpMethod),
      yearOfBirth: entity.yearOfBirth,
    );
  }

  static UserEntity toUserEntity(User user) {
    return UserEntity()
      ..userId = user.id
      ..gender = user.gender.name
      ..yearOfBirth = user.yearOfBirth
      ..signUpMethod = user.signUpMethod.name
      ..name = user.name
      ..email = user.email;
  }

  static User fromLoginResponse$UserInfo({
    required LoginResponse$UserInfo userInfo,
    required String email,
  }) {
    return User(
      id: userInfo.id!,
      gender: Gender.values.byName(userInfo.gender!),
      yearOfBirth: int.parse(userInfo.birthyear!),
      signUpMethod: SignUpMethod.of(userInfo.social!),
      email: email,
      name: userInfo.username,
    );
  }
}
