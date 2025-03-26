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
        TargetPlatform.iOS => await _migrateIosUser(),
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

    unawaited(file.delete().then((_) => null).catchError((_) => null));

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

    await prefs.remove(emailKey);
    return user;
  }
}
