part of 'contact_us_bloc.dart';

sealed class ContactUsEvent extends Equatable {
  const ContactUsEvent();

  @override
  List<Object> get props => [];
}

class ContactUs extends ContactUsEvent {
  const ContactUs({
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.message,
  });

  final String userId;
  final String userEmail;
  final String userName;
  final String message;

  @override
  List<Object> get props => [
        userId,
        userEmail,
        userName,
        message,
      ];
}
