// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// Project imports:
import 'package:bladderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:bladderly/data/isar/schema/apple_credential_entity.dart';
import 'package:bladderly/data/isar/schema/user_entity.dart';
import 'package:bladderly/data/mapper/user_mapper.dart';
import 'package:bladderly/domain/exception/invalid_user_exception.dart';
import 'package:bladderly/domain/exception/not_found_apple_credential_exception.dart';
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/exception/not_found_user_identifier_exception.dart';
import 'package:bladderly/domain/exception/unknown_exception.dart';
import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required DeviceInfoModel deviceInfoModel,
    required IsarClient isarClient,
    required ApiClient apiClient,
  })  : _deviceInfoModel = deviceInfoModel,
        _isarClient = isarClient,
        _apiClient = apiClient,
        _userSubject = BehaviorSubject();

  final DeviceInfoModel _deviceInfoModel;
  final IsarClient _isarClient;
  final ApiClient _apiClient;

  final BehaviorSubject<User?> _userSubject;

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
      if (response.message!.contains('UserNotFoundException')) {
        throw const NotFoundUserException(message: 'not found user');
      }

      if (response.message!.contains('NotAuthorizedException')) {
        throw const InvalidUserException(message: 'invalid user');
      }

      throw UnknownException(message: response.message!);
    }

    final user = UserMapper.fromLoginResponse$UserInfo(userInfo: userInfo, email: email);

    return _saveUserToLocal(user);
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
      social: SignUpMethod.N.value,
    );

    final response = await _apiClient.signUp(request: signUpRequest).then((response) => response.body!);

    final user = User(
      id: response.id!,
      gender: gender,
      yearOfBirth: yearOfBirth,
      signUpMethod: SignUpMethod.N,
    );

    return _saveUserToLocal(user);
  }

  @override
  Future<User> signUp({
    required String userId,
    required String email,
    required String password,
    required String userName,
    required String disease,
  }) async {
    final user = switch (_isarClient.getUserOrNullByUserId(userId)) {
      final UserEntity userEntity =>
        UserMapper.fromUserEntity(userEntity).copyWith(email: email, name: userName, disease: disease),
      _ => throw const NotFoundUserException(message: 'not found user'),
    };

    final signUpRequest = SignUpRequest(
      gender: user.gender.name,
      birthyear: '${user.yearOfBirth}',
      social: user.signUpMethod.value,
      email: user.email,
      pw: password,
      device: _deviceInfoModel.name,
      region: _deviceInfoModel.region,
    );

    return _apiClient
        .signUp(request: signUpRequest)
        .then((response) => response.body!)
        .then((_) => _saveUserToLocal(user))
        .then((_) => user);
  }

  @override
  Future<User> signUpSocial({
    required SignUpMethod signUpMethod,
    required Gender gender,
    required int yearOfBirth,
    required String email,
    required String password,
    required String userName,
    required String disease,
  }) async {
    final signUpRequest = SignUpRequest(
      gender: gender.name,
      birthyear: '$yearOfBirth',
      social: signUpMethod.value,
      disease: disease,
      email: email,
      pw: password,
      device: _deviceInfoModel.name,
      region: _deviceInfoModel.region,
      username: userName,
    );

    final response = await _apiClient.signUp(request: signUpRequest).then((response) => response.body!);

    final user = User(
      id: response.id!,
      signUpMethod: signUpMethod,
      gender: gender,
      yearOfBirth: yearOfBirth,
      email: email,
      name: userName,
      disease: disease,
    );

    return _saveUserToLocal(user);
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
  Stream<User?> get userStream => _userSubject.stream;

  @override
  User? getUserOrNullByUserId(String userId) {
    final userEntity = _isarClient.getUserOrNullByUserId(userId);

    if (userEntity == null) {
      return null;
    }

    return _saveUserToLocal(UserMapper.fromUserEntity(userEntity));
  }

  User _saveUserToLocal(User user) {
    _isarClient.saveUser(UserMapper.toUserEntity(user));
    _userSubject.add(user);

    return user;
  }

  void _clearUserFromLocal() {
    _isarClient.clearAll();
    _userSubject.add(null);
  }
}
