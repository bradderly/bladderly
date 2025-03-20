part of 'contact_us_bloc.dart';

sealed class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

final class ContactUsInitial extends ContactUsState {
  const ContactUsInitial();
}

final class ContactUsSubmitInProgress extends ContactUsState {
  const ContactUsSubmitInProgress();
}

final class ContactUsSubmitSuccess extends ContactUsState {
  const ContactUsSubmitSuccess();
}

final class ContactUsSubmitFailure extends ContactUsState {
  const ContactUsSubmitFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
