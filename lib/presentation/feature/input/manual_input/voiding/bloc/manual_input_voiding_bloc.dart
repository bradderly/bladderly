import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'manual_input_voiding_event.dart';
part 'manual_input_voiding_state.dart';

class ManualInputVoidingBloc extends Bloc<ManualInputVoidingEvent, ManualInputVoidingState> {
  ManualInputVoidingBloc() : super(ManualInputVoidingInitial()) {
    on<ManualInputVoidingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
