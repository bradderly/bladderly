part of 'contact_us_bloc.dart';

sealed class ContactUsEvent extends Equatable {
  const ContactUsEvent();

  @override
  List<Object> get props => [];
}

class ContactUs extends ContactUsEvent {
  const ContactUs({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.message,
    required this.subject,
  });

  final String email;
  final String firstName;
  final String lastName;
  final String message;
  final String subject;

  @override
  List<Object> get props => [
        email,
        firstName,
        lastName,
        message,
        subject,
      ];
}
