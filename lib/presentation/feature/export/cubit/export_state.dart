part of 'export_cubit.dart';

sealed class ExportState extends Equatable {
  const ExportState();

  @override
  List<Object> get props => [];
}

final class ExportInitial extends ExportState {}
