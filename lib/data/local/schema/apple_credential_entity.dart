// Package imports:
import 'package:objectbox/objectbox.dart';

@Entity()
class AppleCredentialEntity {
  @Id()
  int id = 0;

  @Unique(onConflict: ConflictStrategy.replace)
  late String userIdentifier;

  late String email;
}
