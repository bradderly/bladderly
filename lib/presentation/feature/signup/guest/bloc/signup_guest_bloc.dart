import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bradderly/domain/model/sex.dart';
import 'package:bradderly/domain/usecase/signup_guest_usecase.dart';
import 'package:bradderly/presentation/common/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_guest_event.dart';
part 'signup_guest_state.dart';

class SignupGuestBloc extends Bloc<SignupGuestEvent, SignupGuestState> {
  SignupGuestBloc({
    required SignupGuestUsecase signupGuestUsecase,
  })  : _signupGuestUsecase = signupGuestUsecase,
        super(const SignupGuestInitial()) {
    on<SignupGuestSubmit>(_onSubmit, transformer: droppable());
  }

  final SignupGuestUsecase _signupGuestUsecase;

  Future<void> _onSubmit(SignupGuestSubmit event, Emitter<SignupGuestState> emit) async {
    emit(const SignupGuestSubmitInProgress());

    final result = await _signupGuestUsecase(
      sex: event.sex,
      yearOfBirth: event.yearOfBirth,
    );

    result.fold(
      (exception) => emit(SignupGuestSubmitFailure(exception: exception)),
      (user) => emit(SignupGuestSubmitSuccess(userModel: UserModel.fromDomain(user))),
    );
  }
}
