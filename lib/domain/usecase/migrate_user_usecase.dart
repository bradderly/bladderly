import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:xml2json/xml2json.dart';

@lazySingleton
class MigrateUserUsecase {
  const MigrateUserUsecase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  Future<Either<Exception, User>> call() async {
    try {
      final user = switch (defaultTargetPlatform) {
        TargetPlatform.android => await _migrateAndroidUser(),
        _ => throw UnsupportedError('Unsupported platform'),
      };

      return Right(user);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<User> _migrateAndroidUser() async {
    const filePath =
        '/data/data/com.soundable.diaryandroid.us/shared_prefs/com.soundable.diaryandroid.us_preferences.xml';

    final file = File(filePath);

    if (!file.existsSync()) throw Exception('File not found: $filePath');

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

    final yearOfBirth = switch (data['birthday']) {
      final String birthday => int.tryParse(birthday.split('-').first),
      _ => throw Exception('Invalid birthday'),
    };

    final name = switch (data['firstName']) {
      final String firstName => firstName,
      _ => throw Exception('Invalid firstName'),
    };

    final gender = switch (data['gender']) {
      final String gender => Gender.values.byName(gender),
      _ => throw Exception('Invalid Gender'),
    };

    final email = switch (data['email']) {
      final String email => email,
      _ => throw Exception('Invalid email'),
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

    unawaited(file.delete().then((_) => null).catchError((_) => null));

    return user;
  }

  Future<User> _migrateIosUser() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('shUDUserEmail');

    throw UnimplementedError('Not implemented yet');

    /// TODO(신중석): iOS 데이터 읽어서 User 객체로 변환
  }
}
