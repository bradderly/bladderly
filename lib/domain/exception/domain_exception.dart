import 'package:equatable/equatable.dart';

abstract class DomainException implements Exception {
  const DomainException({required this.message});

  final String message;

  String _mapPropsToString(Type runtimeType, List<Object?> props) {
    return '$runtimeType(${props.map((prop) => prop.toString()).join(', ')})';
  }

  List<Object?> get props => [
        message,
      ];

  @override
  String toString() => EquatableConfig.stringify ? _mapPropsToString(runtimeType, props) : '$runtimeType';
}
