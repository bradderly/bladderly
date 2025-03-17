import 'package:bladderly/domain/exception/already_exist_user_exception.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/usecase/check_already_exist_user_usecase.dart';
import 'package:bladderly/domain/usecase/sign_in_social_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_method_event.dart';
part 'sign_up_method_state.dart';

class SignUpMethodBloc extends Bloc<SignUpMethodEvent, SignUpMethodState> {
  SignUpMethodBloc({
    required SignInSocialUsecase signInSocialUsecase,
    required CheckAlreadyExistUserUsecase checkAlreadyExistUserUsecase,
  })  : _signInSocialUsecase = signInSocialUsecase,
        _checkAlreadyExistUserUsecase = checkAlreadyExistUserUsecase,
        super(const SignUpMethodInitial()) {
    on<SignUpMethodSelect>(_onSelect, transformer: droppable());
    on<SignUpMethodCheckDuplicateEmail>(_onCheckDuplicateEmail, transformer: droppable());
  }

  final SignInSocialUsecase _signInSocialUsecase;
  final CheckAlreadyExistUserUsecase _checkAlreadyExistUserUsecase;

  Future<void> _onSelect(SignUpMethodSelect event, Emitter<SignUpMethodState> emit) async {
    if (event.method == SignUpMethod.N) return;

    emit(SignUpMethodSelectInProgress(method: event.method));

    if (event.method == SignUpMethod.E) return emit(SignUpMethodSelectSuccess(method: event.method));

    final result = await _signInSocialUsecase(signUpMethod: event.method);

    return result.fold(
      (exception) => emit(SignUpMethodSelectFailure(exception: exception, method: event.method)),
      (email) => emit(SignUpMethodSelectSuccess(method: event.method, email: email)),
    );
  }

  Future<void> _onCheckDuplicateEmail(SignUpMethodCheckDuplicateEmail event, Emitter<SignUpMethodState> emit) async {
    emit(SignUpMethodCheckDuplicateEmailInProgress(email: event.email, method: event.method));

    final result = await _checkAlreadyExistUserUsecase(email: event.email);

    return result.fold(
      (exception) => emit(
        SignUpMethodCheckDuplicateEmailFailure(exception: exception, email: event.email, method: event.method),
      ),
      (alreadyExist) => alreadyExist
          ? emit(
              SignUpMethodCheckDuplicateEmailFailure(
                exception: AlreadyExistUserException(),
                method: event.method,
                email: event.email,
              ),
            )
          : emit(SignUpMethodCheckDuplicateEmailSuccess(method: event.method, email: event.email)),
    );
  }
}
