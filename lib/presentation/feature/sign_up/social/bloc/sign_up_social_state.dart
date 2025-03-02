part of 'sign_up_social_bloc.dart';

sealed class SignUpSocialState extends Equatable {
  const SignUpSocialState();

  @override
  List<Object> get props => [];
}

final class SignUpSocialInitial extends SignUpSocialState {
  const SignUpSocialInitial();
}

final class SignUpSocialSubmitInProgress extends SignUpSocialState {
  const SignUpSocialSubmitInProgress();
}

final class SignUpSocialSubmitSuccess extends SignUpSocialState {
  const SignUpSocialSubmitSuccess();
}

final class SignUpSocialSubmitFailure extends SignUpSocialState {
  const SignUpSocialSubmitFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
