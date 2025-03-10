part of 'contact_us_form_cubit.dart';

class ContactUsFormState extends Equatable {
  const ContactUsFormState({
    this.id = '',
    this.name = '',
    this.email = '',
    this.message = '',
  });

  final String id;
  final String name;
  final String email;
  final String message;

  ContactUsFormState copyWith({
    String? id,
    String? name,
    String? email,
    String? message,
  }) {
    return ContactUsFormState(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
    );
  }

  bool get isValid => id.isNotEmpty && name.isNotEmpty && email.isNotEmpty && message.isNotEmpty;

  @override
  List<Object> get props => [
        id,
        name,
        email,
        message,
      ];
}
