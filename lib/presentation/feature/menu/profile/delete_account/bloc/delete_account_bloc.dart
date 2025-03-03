import 'package:bladderly/domain/usecase/delete_account_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc({
    required DeleteAccountUsecase deleteAccountUsecase,
  })  : _deleteAccount = deleteAccountUsecase,
        super(const DeleteAccountInitial()) {
    on<DeleteAccountEvent>(
      (event, emit) => switch (event) {
        DeleteAccount() => _onDeleteAccount(event, emit),
      },
      transformer: droppable(),
    );
  }

  final DeleteAccountUsecase _deleteAccount;

  Future<void> _onDeleteAccount(DeleteAccount event, Emitter<DeleteAccountState> emit) async {
    emit(const DeleteAccountProgress());

    final result = await _deleteAccount(
      email: event.email,
    );

    result.fold(
      (exception) => emit(DeleteAccountFailure(exception: exception)),
      (success) => emit(const DeleteAccountSuccess()),
    );
  }
}
