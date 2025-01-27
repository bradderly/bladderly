part of 'export_bloc.dart';

sealed class ExportEvent extends Equatable {
  const ExportEvent();

  @override
  List<Object> get props => [];
}

final class ExportExportHistories extends ExportEvent {
  const ExportExportHistories({
    required this.dates,
    required this.email,
  });

  final List<DateTime> dates;

  final String email;

  @override
  List<Object> get props => [
        email,
      ];
}
