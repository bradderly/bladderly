part of 'plan_form_cubit.dart';

class PlanFormState extends Equatable {
  const PlanFormState({
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.message = '',
    this.subject = '',
  });

  final String email;
  final String firstName;
  final String lastName;
  final String message;
  final String subject;

  PlanFormState copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? message,
    String? subject,
  }) {
    return PlanFormState(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      message: message ?? this.message,
      subject: subject ?? this.subject,
    );
  }

  bool get isValid =>
      email.isNotEmpty && firstName.isNotEmpty && lastName.isNotEmpty && message.isNotEmpty && subject.isNotEmpty;

  @override
  List<Object> get props => [
        email,
        firstName,
        lastName,
        message,
        subject,
      ];
}
