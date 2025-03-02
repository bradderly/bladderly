// Package imports:
import 'package:isar/isar.dart';

part 'apple_credential_entity.g.dart';

@collection
class AppleCredentialEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  @Name('user_identifier')
  late String userIdentifier;

  @Name('email')
  late String email;
}
