import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/model/user.dart';

abstract class AuthRepository {
  /// 회원 가입
  /// socialSigninMethod가 not null인 경우에 SNS 로그인 케이스
  Future<User> signUpGuest({
    required Gender gender,
    required int yearOfBirth,
    required SignUpMethod signUpMethod,
  });

  /// 정회원 전환
  /// email, password가 없는 경우 SNS 로그인 케이스
  Future<User> signUp({
    required String userId,
    required String userName,
    required String disease,
    String? email,
    String? password,
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

  Stream<User?> get userStream;

  User? getUserOrNullByUserId(String userId);
}
