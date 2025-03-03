part of 'contact_us_form_cubit.dart';

class ContactUsFormState extends Equatable {
  const ContactUsFormState({
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

  ContactUsFormState copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? message,
    String? subject,
  }) {
    return ContactUsFormState(
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
