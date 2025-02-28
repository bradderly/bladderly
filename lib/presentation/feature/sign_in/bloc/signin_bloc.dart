import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/usecase/sign_in_social_usecase.dart';
import 'package:bladderly/domain/usecase/sign_in_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required SignInUsecase signinUsecase,
    required SignInSocialUsecase signinSocialUsecase,
  })  : _signinUsecase = signinUsecase,
        _signinSocialUsecase = signinSocialUsecase,
        super(const SignInInitial()) {
    on<SignInEvent>(
      (event, emit) => switch (event) {
        SignInEmail() => _onSigninEmail(event, emit),
        SignInSocial() => _onSigninSocial(event, emit),
      },
      transformer: droppable(),
    );
  }

  final SignInUsecase _signinUsecase;
  final SignInSocialUsecase _signinSocialUsecase;

  Future<void> _onSigninEmail(SignInEmail event, Emitter<SignInState> emit) async {
    emit(const SignInInProgress());

    final result = await _signinUsecase(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (exception) => emit(SignInEmailFailure(exception: exception)),
      (success) => emit(const SignInEmailSuccess()),
    );
  }

  Future<void> _onSigninSocial(SignInSocial event, Emitter<SignInState> emit) async {
    emit(const SignInInProgress());

    final result = await _signinSocialUsecase(signUpMethod: event.signUpMethod);

    result.fold(
      (exception) => emit(SignInSocialFailure(signUpMethod: event.signUpMethod, exception: exception)),
      (email) => emit(SignInSocialSuccess(email: email, signUpMethod: event.signUpMethod)),
    );
  }
}
