import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bladderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:bladderly/domain/repository/score_repository.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';

@lazySingleton
class MigrateUserUsecase {
  const MigrateUserUsecase({
    required UserRepository userRepository,
    required HistoryRepository historyRepository,
    required ScoreRepository scoreRepository,
    required DeviceInfoModel deviceInfoModel,
  })  : _userRepository = userRepository,
        _historyRepository = historyRepository,
        _scoreRepository = scoreRepository,
        _deviceInfoModel = deviceInfoModel;

  final UserRepository _userRepository;
  final HistoryRepository _historyRepository;
  final ScoreRepository _scoreRepository;
  final DeviceInfoModel _deviceInfoModel;

  Future<Either<Exception, User>> call() async {
    try {
      final user = switch (defaultTargetPlatform) {
        TargetPlatform.android => await _migrateAndroidUser(),
        TargetPlatform.iOS => await _migrateIosUser(),
        _ => throw UnsupportedError('Unsupported platform'),
      };

      final localUserId = _userRepository.getLocalUserIdByUserId(user.userId)!;

      await Future.wait(
        [
          _userRepository.changeContry(userId: user.userId, country: _deviceInfoModel.region),
          _historyRepository.getAllHistoriesFromServer(user.userId).then(_historyRepository.saveHistories),
          _scoreRepository.getAllScoreHistoriesFromServer(user.userId).then(_scoreRepository.saveScores),
          _userRepository.getMembershipFromServer(userId: user.userId).then(
                (value) =>
                    value == null ? null : _userRepository.saveMembership(localUserId: localUserId, membership: value),
              ),
        ],
      ).catchError((_) => <void>[]);

      return Right(user);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<User> _migrateAndroidUser() async {
    final file =
        File('/data/data/com.soundable.diaryandroid.us/shared_prefs/com.soundable.diaryandroid.us_preferences.xml');

    if (!file.existsSync()) throw Exception('File not found: ${file.path}');

    final fileContent = file.readAsStringSync();

    final json = Map<String, dynamic>.from(jsonDecode((Xml2Json()..parse(fileContent)).toGData()) as Map? ?? {});
    final map = Map<String, dynamic>.from(json['map'] as Map? ?? {});

    if (map.isEmpty) throw Exception('Invalid map');

    final data = switch (map['string']) {
      final List values =>
        values.cast<Map>().map(Map<String, String>.from).fold<Map<String, String>>(<String, String>{}, (acc, e) {
          final key = e['name'];
          final value = e[r'$t'];
          return {
            ...acc,
            if (key != null && value != null) key: value,
          };
        }),
      _ => throw Exception('Invalid string'),
    };

    final email = switch (data['email']) {
      final String email => email,
      _ => throw Exception('Invalid email'),
    };

    final yearOfBirth = switch (data['birthday']) {
      final String birthday => int.tryParse(birthday.split('-').first),
      _ => 1900,
    };

    final name = data['firstName'];

    final gender = switch (data['gender']) {
      final String gender => gender.toLowerCase() == 'male' ? Gender.male : Gender.female,
      _ => Gender.female,
    };

    final userId = sha1.convert(utf8.encode(email)).toString();

    final user = _userRepository.saveUser(
      User(
        userId: userId,
        yearOfBirth: yearOfBirth,
        name: name,
        gender: gender,
        signUpMethod: SignUpMethod.E,
        email: email,
      ),
    );

    // unawaited(file.delete().then((_) => null).catchError((_) => null));

    return user;
  }

  Future<User> _migrateIosUser() async {
    final prefs = await SharedPreferences.getInstance();

    const emailKey = 'shUDUserEmail';

    final email = prefs.getString(emailKey);

    if (email == null) throw Exception('Invalid email');

    final birthYear = int.tryParse(prefs.getString('shUDUserBirthYear')?.split('-').first ?? '1900');

    final gender = prefs.getString('shUDUserGender') == 'male' ? Gender.male : Gender.female;
    final name = prefs.getString('shUDUserFirstName');

    final user = _userRepository.saveUser(
      User(
        userId: sha1.convert(utf8.encode(email)).toString(),
        yearOfBirth: birthYear,
        name: name,
        gender: gender,
        signUpMethod: SignUpMethod.E,
        email: email,
      ),
    );

    unawaited(prefs.remove(emailKey));

    return user;
  }
}
