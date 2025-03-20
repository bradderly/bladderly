import 'package:bladderly/domain/usecase/reset_password_usecasey.dart';
import 'package:bladderly/domain/usecase/send_verification_code_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required SendVerificationCodeUsecase sendVerificationCodeUsecase,
    required ResetPasswordUsecase resetPasswordUsecase,
  })  : _sendVerificationCodeUsecase = sendVerificationCodeUsecase,
        _resetPasswordUsecase = resetPasswordUsecase,
        super(const ForgotPasswordInitial()) {
    on<ForgotPasswordSendVerificationCode>(_onSendVerificationCode, transformer: droppable());
    on<ForgotPasswordChangePassword>(_onResetPassword, transformer: droppable());
  }

  final SendVerificationCodeUsecase _sendVerificationCodeUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;

  Future<void> _onSendVerificationCode(
    ForgotPasswordSendVerificationCode event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(const ForgotPasswordSendVerificationCodeInProgress());

    final result = await _sendVerificationCodeUsecase(
      email: event.email,
    );

    result.fold(
      (exception) => emit(ForgotPasswordSendVerificationCodeFailure(exception: exception)),
      (_) => emit(const ForgotPasswordSendVerificationCodeSuccess()),
    );
  }

  Future<void> _onResetPassword(
    ForgotPasswordChangePassword event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(const ForgotPasswordResetPasswordInProgress());

    final result = await _resetPasswordUsecase(
      email: event.email,
      password: event.password,
      verificationCode: event.verificationCode,
    );

    result.fold(
      (exception) => emit(ForgotPasswordResetPasswordFailure(exception: exception)),
      (_) => emit(const ForgotPasswordResetPasswordSuccess()),
    );
  }
}
