import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/model/user.dart';

abstract class UserRepository {
  User saveUser(User user);

  Future<String> changeName({
    required String userId,
    required String userName,
    String? userEmail,
  });

  Stream<User?> get userStream;

  User? getUserOrNullByUserId(String userId);

  Future<Membership?> getMembership(String userId);

  Membership saveMembership(Membership membership);
}
