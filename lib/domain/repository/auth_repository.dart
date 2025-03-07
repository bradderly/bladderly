// Project imports:
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/model/user.dart';

abstract class AuthRepository {
  const AuthRepository._();

  /// 게스트 회원 가입
  Future<User> signUpGuest({
    required Gender gender,
    required int yearOfBirth,
  });

  /// 정회원 전환
  Future<User> signUp({
    required String userId,
    required String email,
    required String password,
    required String userName,
    required String disease,
  });

  /// SNS 로그인을 통한 회원가입
  Future<User> signUpSocial({
    required SignUpMethod signUpMethod,
    required Gender gender,
    required int yearOfBirth,
    required String email,
    required String password,
    required String userName,
    required String disease,
  });

  Future<User> signIn({
    required String email,
    required String password,
  });

  /// 구글 로그인 후 이메일 리턴
  Future<String> signInGoogle();

  /// 애플 로그인 후 이메일 리턴
  Future<String> signInApple();

  /// 로그아웃 - 로컬 디비 초기화
  void clearLocal();

  Future<String> changePassword({
    required String email,
    required String newPw,
    required String oldPw,
  });

  Stream<User?> get userStream;

  User? getUserOrNullByUserId(String userId);

  Future<void> signOut(String userId);

  Future<String> changeName({
    required String userId,
    required String userName,
    String? userEmail,
  });

  Future<String> deleteAccount({
    required String email,
  });

  Future<GetVersionResponse> getVersion({
    required String device,
  });

  Future<String> contactUs({
    required String userId,
    required String userEmail,
    required String userName,
    required String message,
  });

  Future<String> checkPromo({
    required String userId,
    required String code,
  });
}
