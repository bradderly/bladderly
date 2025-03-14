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

  Future<Membership?> initializeMembership({
    required String userId,
  });

  Membership saveMembership({
    required int localUserId,
    required Membership membership,
  });

  Stream<Membership?> getMembershipStream({required int localUserId});

  /// 주어진 userId에 해당하는 엔티티의 데이터를 주어진 User의 데이터로 변경한다
  User migrateUser({
    required String userId,
    required User user,
  });

  int? getLocalUserIdByUserId(String userId);
}
