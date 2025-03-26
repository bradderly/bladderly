import 'dart:io';

import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/local/local_storage_client.dart';
import 'package:bladderly/data/mapper/membership_mapper.dart';
import 'package:bladderly/data/mapper/user_mapper.dart';
import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required ApiClient apiClient,
    required LocalStorageClient localStorageClient,
  })  : _apiClient = apiClient,
        _localStorageClient = localStorageClient;

  final ApiClient _apiClient;
  final LocalStorageClient _localStorageClient;

  @override
  Future<String> changeName({
    required String userId,
    required String userName,
    String? userEmail,
  }) async {
    final request = UpdateUserInfoRequest(
      id: userId,
      email: userEmail,
      username: userName,
    );

    final response = await _apiClient.updateUserName(request: request).then((response) => response.body!);

    return response.message ?? (throw Exception('Change Password failed'));
  }

  @override
  User? getUserOrNullByUserId(String userId) {
    final entity = _localStorageClient.getUserOrNullByUserId(userId);
    return entity == null ? null : UserMapper.fromUserEntity(entity);
  }

  @override
  User saveUser(User user) {
    final entity = _localStorageClient.saveUser(UserMapper.toUserEntity(user));

    return UserMapper.fromUserEntity(entity);
  }

  @override
  Stream<User?> get userStream {
    return _localStorageClient.userStream.map((entity) => entity == null ? null : UserMapper.fromUserEntity(entity));
  }

  @override
  Future<Membership?> getMembershipFromServer({
    required String userId,
  }) async {
    final response = await _apiClient
        .getPayInfo(userId: userId, device: Platform.isAndroid ? 'android' : 'ios')
        .then((response) => response.body!);

    return MembershipMapper.fromGetPayResponse(response);
  }

  @override
  Membership saveMembership({
    required int localUserId,
    required Membership membership,
  }) {
    final entity = MembershipMapper.toMembershipEntity(
      localUserId: localUserId,
      membership: membership,
    );

    return MembershipMapper.fromMembershipEntity(_localStorageClient.saveMembership(entity));
  }

  @override
  User migrateUser({
    required String userId,
    required User user,
  }) {
    return UserMapper.fromUserEntity(_localStorageClient.migrateUser(userId, UserMapper.toUserEntity(user)));
  }

  @override
  Stream<Membership?> getMembershipStream({
    required int localUserId,
  }) {
    return _localStorageClient
        .getMembershipStreamByUserId(localUserId)
        .map((entity) => entity == null ? null : MembershipMapper.fromMembershipEntity(entity));
  }

  @override
  int? getLocalUserIdByUserId(String userId) => _localStorageClient.getUserOrNullByUserId(userId)?.id;

  @override
  Membership? getMembershipOrNullByLocalUserId(int localUserId) {
    final entity = _localStorageClient.getMembershipOrNullByUserId(localUserId);
    return entity == null ? null : MembershipMapper.fromMembershipEntity(entity);
  }

  @override
  Future<String> changeContry({
    required String userId,
    required String country,
  }) {
    return _apiClient
        .updateUserName(request: UpdateUserInfoRequest(id: userId, country: country))
        .then((response) => country);
  }
}
