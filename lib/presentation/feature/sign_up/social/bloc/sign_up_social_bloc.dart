import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/usecase/sign_up_social_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_social_event.dart';
part 'sign_up_social_state.dart';

class SignUpSocialBloc extends Bloc<SignUpSocialEvent, SignUpSocialState> {
  SignUpSocialBloc({
    required SignUpSocialUsecase signUpSocialUsecase,
  })  : _signUpSocialUsecase = signUpSocialUsecase,
        super(const SignUpSocialInitial()) {
    on<SignUpSocialSubmit>(_onSubmit, transformer: droppable());
  }

  final SignUpSocialUsecase _signUpSocialUsecase;

  Future<void> _onSubmit(SignUpSocialSubmit event, Emitter<SignUpSocialState> emit) async {
    emit(const SignUpSocialSubmitInProgress());

    final result = await _signUpSocialUsecase(
      email: event.email,
      signUpMethod: event.signUpMethod,
      gender: event.gender,
      yearOfBirth: event.yearOfBirth,
      userName: event.userName,
      disease: event.disease,
    );

    result.fold(
      (exception) => emit(SignUpSocialSubmitFailure(exception: exception)),
      (_) => emit(const SignUpSocialSubmitSuccess()),
    );
  }
}
