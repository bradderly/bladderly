// Package imports:
// Project imports:
import 'package:bladderly/domain/exception/already_exist_user_exception.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/usecase/check_already_exist_user_usecase.dart';
import 'package:bladderly/domain/usecase/sign_up_regular_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_regular_event.dart';
part 'sign_up_regular_state.dart';

class SignUpRegularBloc extends Bloc<SignUpRegularEvent, SignUpRegularState> {
  SignUpRegularBloc({
    required SignUpEmailUsecase signUpEmailUsecase,
    required CheckAlreadyExistUserUsecase checkAlreadyExistUserUsecase,
  })  : _signUpEmailUsecase = signUpEmailUsecase,
        _checkAlreadyExistUserUsecase = checkAlreadyExistUserUsecase,
        super(const SignUpRegularInitial()) {
    on<SignUpRegularCheckDuplicateEmail>(_checkDuplicateEmail, transformer: droppable());
    on<SignUpRegularSubmit>(_onSubmit, transformer: droppable());
  }

  final SignUpEmailUsecase _signUpEmailUsecase;
  final CheckAlreadyExistUserUsecase _checkAlreadyExistUserUsecase;

  Future<void> _checkDuplicateEmail(SignUpRegularCheckDuplicateEmail event, Emitter<SignUpRegularState> emit) async {
    emit(const SignUpRegularCheckDuplicateEmailInProgress());

    final result = await _checkAlreadyExistUserUsecase(email: event.email);

    return result.fold(
      (exception) => emit(SignUpRegularCheckDuplicateEmailFailure(exception: exception)),
      (alreadyExist) => alreadyExist
          ? emit(const SignUpRegularCheckDuplicateEmailFailure(exception: AlreadyExistUserException()))
          : emit(
              const SignUpRegularCheckDuplicateEmailSuccess(),
            ),
    );
  }

  Future<void> _onSubmit(SignUpRegularSubmit event, Emitter<SignUpRegularState> emit) async {
    emit(const SignUpRegularSubmitInProgress());

    final result = await _signUpEmailUsecase(
      signUpMethod: event.signUpMethod,
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
