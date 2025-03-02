// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/domain/usecase/sign_up_email_usecase.dart';

part 'sign_up_regular_event.dart';
part 'sign_up_regular_state.dart';

class SignUpRegularBloc extends Bloc<SignUpRegularEvent, SignUpRegularState> {
  SignUpRegularBloc({
    required SignUpEmailUsecase signUpEmailUsecase,
  })  : _signUpEmailUsecase = signUpEmailUsecase,
        super(const SignUpRegularInitial()) {
    on<SignUpRegularSubmit>(_onSubmit, transformer: droppable());
  }

  final SignUpEmailUsecase _signUpEmailUsecase;

  Future<void> _onSubmit(SignUpRegularSubmit event, Emitter<SignUpRegularState> emit) async {
    emit(const SignUpRegularSubmitInProgress());

    final result = await _signUpEmailUsecase(
      userId: event.userId,
      email: event.email,
      password: event.password,
      userName: event.userName,
      disease: event.disease,
    );

    result.fold(
      (exception) => emit(SignUpRegularSubmitFailure(exception: exception)),
      (user) => emit(const SignUpRegularSubmitSuccess()),
    );
  }
}
