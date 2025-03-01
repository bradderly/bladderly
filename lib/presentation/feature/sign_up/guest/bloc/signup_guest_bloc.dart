// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/usecase/sign_up_guest_usecase.dart';

part 'signup_guest_event.dart';
part 'signup_guest_state.dart';

class SignUpGuestBloc extends Bloc<SignUpGuestEvent, SignUpGuestState> {
  SignUpGuestBloc({
    required SignUpGuestUsecase signupGuestUsecase,
  })  : _signupGuestUsecase = signupGuestUsecase,
        super(const SignupGuestInitial()) {
    on<SignupGuestSubmit>(_onSubmit, transformer: droppable());
  }

  final SignUpGuestUsecase _signupGuestUsecase;

  Future<void> _onSubmit(SignupGuestSubmit event, Emitter<SignUpGuestState> emit) async {
    emit(const SignupGuestSubmitInProgress());

    final result = await _signupGuestUsecase(gender: event.gender, yearOfBirth: event.yearOfBirth);

    result.fold(
      (exception) => emit(SignupGuestSubmitFailure(exception: exception)),
      (user) => emit(const SignupGuestSubmitSuccess()),
    );
  }
}
