part of 'delete_account_bloc.dart';

sealed class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class DeleteAccount extends DeleteAccountEvent {
  const DeleteAccount({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [
        email,
      ];
}
