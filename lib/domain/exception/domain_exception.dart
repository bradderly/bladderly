// Package imports:
import 'package:equatable/equatable.dart';

abstract class DomainException extends Equatable implements Exception {
  const DomainException({
    required this.message,
    this.title,
    this.button = 'Okay',
  });

  final String? title;
  final String message;
  final String button;

  @override
  List<Object?> get props => [
        title,
        message,
        button,
      ];
}
