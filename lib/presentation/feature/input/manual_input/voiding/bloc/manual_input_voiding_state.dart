part of 'manual_input_voiding_bloc.dart';

sealed class ManualInputVoidingState extends Equatable {
  const ManualInputVoidingState();
  
  @override
  List<Object> get props => [];
}

final class ManualInputVoidingInitial extends ManualInputVoidingState {}
