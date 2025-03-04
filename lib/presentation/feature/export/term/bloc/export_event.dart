part of 'export_bloc.dart';

sealed class ExportEvent extends Equatable {
  const ExportEvent();

  @override
  List<Object> get props => [];
}

final class ExportExportHistories extends ExportEvent {
  const ExportExportHistories({
    required this.userId,
    required this.email,
    required this.dates,
  });

  final String userId;
  final String email;
  final List<DateTime> dates;

  @override
  List<Object> get props => [
        userId,
        email,
        dates,
      ];
}
