// Package imports:
// Project imports:
import 'package:bladderly/domain/usecase/contact_us_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_us_event.dart';
part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  ContactUsBloc({
    required ContactUsUsecase contactUsUsecase,
  })  : _contactUsUsecase = contactUsUsecase,
        super(const ContactUsInitial()) {
    on<ContactUsEvent>(
      (event, emit) => switch (event) {
        ContactUs() => _onChangePassord(event, emit),
      },
      transformer: droppable(),
    );
  }

  final ContactUsUsecase _contactUsUsecase;

  Future<void> _onChangePassord(ContactUs event, Emitter<ContactUsState> emit) async {
    emit(const ContactUsProgress());

    final result = await _contactUsUsecase(
      userId: event.userId,
      userEmail: event.userEmail,
      userName: event.userName,
      message: event.message,
    );

    result.fold(
      (exception) => emit(ContactUsFailure(exception: exception)),
      (success) => emit(const ContactUsSuccess()),
    );
  }
}
