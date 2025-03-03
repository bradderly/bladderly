part of 'contact_us_bloc.dart';

sealed class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

final class ContactUsInitial extends ContactUsState {
  const ContactUsInitial();
}

final class ContactUsProgress extends ContactUsState {
  const ContactUsProgress();
}

final class ContactUsSuccess extends ContactUsState {
  const ContactUsSuccess();
}

final class ContactUsFailure extends ContactUsState {
  const ContactUsFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
