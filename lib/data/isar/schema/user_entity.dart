import 'package:isar/isar.dart';

part 'user_entity.g.dart';

@collection
class UserEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  @Name('user_id')
  late String userId;

  @Name('gender')
  late String gender;

  @Name('year_of_birth')
  late int yearOfBirth;

  @Name('signup_method')
  late String signupMethod;

  @Name('name')
  String? name;

  @Name('email')
  String? email;
}
