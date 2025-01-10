import 'package:flutter/material.dart';

class BladderlyTextStyleTheme extends ThemeExtension<BladderlyTextStyleTheme> {
  BladderlyTextStyleTheme();

  final _outfit = 'Outfit';
  final _inter = 'Inter';

  late final bDisplay1Bold = TextStyle(
    fontSize: 42,
    height: 58 / 42,
    fontWeight: FontWeight.bold,
    fontFamily: _outfit,
  );

  late final bDisplay2Bold = TextStyle(
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.bold,
    fontFamily: _outfit,
  );

  late final b28Bold = TextStyle(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.bold,
    fontFamily: _outfit,
  );

  late final b24BoldOutfit = TextStyle(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.bold,
    fontFamily: _outfit,
  );

  late final b24Bold = TextStyle(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.bold,
    fontFamily: _inter,
  );

  late final b24Medium = TextStyle(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w500,
    fontFamily: _inter,
  );

  late final b20Bold = TextStyle(
    fontSize: 20,
    height: 24 / 20,
    fontWeight: FontWeight.bold,
    fontFamily: _inter,
  );

  late final b20Medium = TextStyle(
    fontSize: 20,
    height: 24 / 20,
    fontWeight: FontWeight.w500,
    fontFamily: _inter,
  );

  late final b18Bold = TextStyle(
    fontSize: 18,
    height: 22 / 18,
    fontWeight: FontWeight.bold,
    fontFamily: _inter,
  );

  late final b18SemiBold = TextStyle(
    fontSize: 18,
    height: 22 / 18,
    fontWeight: FontWeight.w600,
    fontFamily: _inter,
  );

  late final b18Medium = TextStyle(
    fontSize: 18,
    height: 22 / 18,
    fontWeight: FontWeight.w500,
    fontFamily: _inter,
  );

  late final b18Regular = TextStyle(
    fontSize: 18,
    height: 22 / 18,
    fontWeight: FontWeight.w400,
    fontFamily: _inter,
  );

  late final b16SemiBold = TextStyle(
    fontSize: 16,
    height: 1.2,
    fontWeight: FontWeight.w600,
    fontFamily: _inter,
  );

  late final b16Medium = TextStyle(
    fontSize: 16,
    height: 1.2,
    fontWeight: FontWeight.w500,
    fontFamily: _inter,
  );

  late final b16Regular = TextStyle(
    fontSize: 16,
    height: 1.2,
    fontWeight: FontWeight.w400,
    fontFamily: _inter,
  );

  late final b14Regular = TextStyle(
    fontSize: 14,
    height: 1.2,
    fontWeight: FontWeight.w400,
    fontFamily: _inter,
  );

  late final b14Medium = TextStyle(
    fontSize: 14,
    height: 1.2,
    fontWeight: FontWeight.w500,
    fontFamily: _inter,
  );

  late final b14SemiBold = TextStyle(
    fontSize: 14,
    height: 1.2,
    fontWeight: FontWeight.w600,
    fontFamily: _inter,
  );

  late final b12Medium = TextStyle(
    fontSize: 12,
    height: 1.2,
    fontWeight: FontWeight.w500,
    fontFamily: _inter,
  );

  late final b12SemiBold = TextStyle(
    fontSize: 12,
    height: 1.2,
    fontWeight: FontWeight.w600,
    fontFamily: _inter,
  );

  late final actionButton14 = TextStyle(
    fontSize: 14,
    height: 18 / 14,
    fontWeight: FontWeight.w500,
    fontFamily: _inter,
  );

  late final actionLink14 = TextStyle(
    fontSize: 14,
    height: 18 / 14,
    fontWeight: FontWeight.w600,
    fontFamily: _inter,
  );

  late final actionButton12 = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    fontFamily: _inter,
  );

  @override
  ThemeExtension<BladderlyTextStyleTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<BladderlyTextStyleTheme> lerp(ThemeExtension<BladderlyTextStyleTheme>? other, double t) {
    return this;
  }
}
