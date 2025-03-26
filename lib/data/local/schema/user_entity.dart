// Package imports:
import 'package:objectbox/objectbox.dart';

@Entity()
class UserEntity {
  @Id()
  int id = 0;

  @Unique(onConflict: ConflictStrategy.replace)
  late String userId;

  late String gender;

  late int? yearOfBirth;

  late String signUpMethod;

  String? name;

  String? email;

  void changeUserInfo({
    String? userId,
    String? email,
    String? name,
    String? signUpMethod,
  }) {
    this.userId = userId ?? this.userId;
    this.email = email;
    this.name = name;
    this.signUpMethod = signUpMethod ?? this.signUpMethod;
  }
}
