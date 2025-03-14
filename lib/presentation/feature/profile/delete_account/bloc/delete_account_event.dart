part of 'delete_account_bloc.dart';

sealed class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class DeleteAccount extends DeleteAccountEvent {
  const DeleteAccount({
    required this.id,
    required this.email,
    required this.reason,
  });

  final String email;
  final String id;
  final String reason;

  @override
  List<Object> get props => [
        email,
        id,
        reason,
      ];
}
