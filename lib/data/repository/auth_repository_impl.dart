// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:bladderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:bladderly/data/isar/schema/apple_credential_entity.dart';
import 'package:bladderly/data/mapper/user_mapper.dart';
import 'package:bladderly/domain/exception/invalid_user_exception.dart';
import 'package:bladderly/domain/exception/not_found_apple_credential_exception.dart';
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/exception/not_found_user_identifier_exception.dart';
import 'package:bladderly/domain/exception/password_attempts_exceeded_exception.dart';
import 'package:bladderly/domain/exception/unknown_exception.dart';
import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
// Package imports:
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required DeviceInfoModel deviceInfoModel,
    required IsarClient isarClient,
    required ApiClient apiClient,
  })  : _deviceInfoModel = deviceInfoModel,
        _isarClient = isarClient,
        _apiClient = apiClient;

  final DeviceInfoModel _deviceInfoModel;
  final IsarClient _isarClient;
  final ApiClient _apiClient;

  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest(email: email, pw: password);

    final response = await _apiClient.logIn(request: request).then(
          (response) => response.body == null
              ? LoginResponse.fromJson((jsonDecode(response.bodyString) as Map).cast<String, dynamic>())
              : response.body!,
        );

    final userInfo = response.userInfo;

    if (userInfo == null) {
      if (response.message!.contains('User does not exist')) {
        throw const NotFoundUserException(message: 'not found user');
      }

      if (response.message!.contains('Incorrect username or password')) {
        throw const InvalidUserException();
      }

      if (response.message!.contains('Password attempts exceeded')) {
        throw const PasswordAttemptsExceededException();
      }

      throw UnknownException(message: response.message!);
    }

    return UserMapper.fromLoginResponseUserInfo(userInfo: userInfo, email: email);
  }

  @override
  Future<User> signUpGuest({
    required Gender gender,
    required int yearOfBirth,
  }) async {
    final signUpRequest = SignUpRequest(
      gender: gender.name,
      birthyear: '$yearOfBirth',
      device: _deviceInfoModel.name,
      region: _deviceInfoModel.region,
      social: SignUpMethod.N.name,
      env: kDebugMode ? 'sandbox' : null,
    );

    final response = await _apiClient.signUp(request: signUpRequest).then((response) => response.body!);

    return User(
      userId: response.id!,
      gender: gender,
      yearOfBirth: yearOfBirth,
      signUpMethod: SignUpMethod.N,
    );
  }

  @override
  Future<String> signUp({
    required String userId,
    required String gender,
    required String yearOfBirth,
    required String signUpMethod,
    required String email,
    required String password,
    required String userName,
    required String disease,
  }) async {
    final signUpRequest = SignUpRequest(
      id: userId,
      gender: gender,
      birthyear: yearOfBirth,
      social: signUpMethod,
      email: email,
      pw: password,
      username: userName,
      disease: disease,
      device: _deviceInfoModel.name,
      region: _deviceInfoModel.region,
    );

    final response = await _apiClient.signUp(request: signUpRequest).then((response) => response.body!);

    return response.id!;
  }

  @override
  Future<User> signUpSocial({
    required String? userId,
    required SignUpMethod signUpMethod,
    required Gender gender,
    required int yearOfBirth,
    required String email,
    required String password,
    required String userName,
    required String disease,
  }) async {
    final signUpRequest = SignUpRequest(
      id: userId,
      gender: gender.name,
      birthyear: '$yearOfBirth',
      social: signUpMethod.name,
      disease: disease,
      email: email,
      pw: password,
      device: _deviceInfoModel.name,
      region: _deviceInfoModel.region,
      username: userName,
    );

    final response = await _apiClient.signUp(request: signUpRequest).then((response) => response.body!);

    return User(
      userId: response.id!,
      signUpMethod: signUpMethod,
      gender: gender,
      yearOfBirth: yearOfBirth,
      email: email,
      name: userName,
      disease: disease,
    );
  }

  @override
  Future<String> signInApple() async {
    /// 애플 로그인은 첫 로그인 이후 부터는 메일을 제공하지 않음.
    /// 서버에 userIdentifier에 저장하거나 로컬 DB에 저장하여 사용 해야함.
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
      ],
    );

    /// Platform이 IOS가 아닌경우에 null 일수 있음.
    final userIdentifier =
        credential.userIdentifier ?? (throw const NotFoundUserIdentifierException(message: 'IOS가 아닌 기기는 지원하지 않습니다.'));
    final email = credential.email;
    final isFirstSignin = email != null;

    if (isFirstSignin) {
      return _isarClient
          .saveAppleCredential(
            AppleCredentialEntity()
              ..userIdentifier = userIdentifier
              ..email = email,
          )
          .email;
    }

    final entity = _isarClient.getAppleCredentialOrNullByUserIdentifier(userIdentifier);

    return entity?.email ?? (throw const NotFoundAppleCredentialException(message: 'Apple Credential not found'));
  }

  @override
  Future<String> signInGoogle() async {
    final credential = await GoogleSignIn.standard().signIn();

    return credential?.email ?? (throw Exception('Google Sign In failed'));
  }

  @override
  void clearLocal() {
    _clearUserFromLocal();
  }

  @override
  Future<String> changePassword({
    required String email,
    required String newPw,
    required String oldPw,
  }) async {
    final request = ChagePwRequest(email: email, newPw: newPw, oldPw: oldPw);

    final response = await _apiClient.changePassword(request: request).then((response) => response.body!);

    return response.message ?? (throw Exception('Change Password failed'));
  }

  @override
  Future<String> deleteAccount({
    required String email,
  }) async {
    final request = PostEmailRequest(email: email);

    final response = await _apiClient.deleteAccount(request: request).then((response) => response.body!);

    return response.message ?? (throw Exception('Delete Account failed'));
  }

  @override
  Future<String> contactUs({
    required String userId,
    required String userEmail,
    required String userName,
    required String message,
  }) async {
    final response = await _apiClient
        .contactUs(request: ContactUsRequest(id: userId, email: userEmail, preferredName: userName, message: message))
        .then((response) => response.body!);

    return response.message ?? (throw Exception('Contact Us failed'));
  }

  void _clearUserFromLocal() {
    _isarClient.clearAll();
  }

  @override
  Future<void> signOut(String userId) {
    return _apiClient.logOut(request: {'id': userId});
  }

  @override
  Future<String> sendVerificationCode({
    required String email,
  }) {
    return _apiClient
        .forgotPassword(request: PostEmailRequest(email: email))
        .then((response) => response.body!.message!);
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String password,
    required String verificationCode,
  }) async {
    return _apiClient
        .confirmPassword(request: ConfirmPwRequest(email: email, newPw: password, verificationCode: verificationCode))
        .then((response) => response.body!);
  }
}
