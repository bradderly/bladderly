part of 'export_bloc.dart';

sealed class ExportState extends Equatable {
  const ExportState({
    required this.selectedDates,
  });

  final List<DateTime> selectedDates;

  @override
  List<Object> get props => [
        selectedDates,
      ];
}

final class ExportInitial extends ExportState {
  const ExportInitial() : super(selectedDates: const []);
}

final class ExportExportHistoriesInProgress extends ExportState {
  const ExportExportHistoriesInProgress({
    required super.selectedDates,
  });
}

final class ExportExportHistoriesSuccess extends ExportState {
  const ExportExportHistoriesSuccess({
    required super.selectedDates,
  });
}

final class ExportExportHistoriesFailure extends ExportState {
  const ExportExportHistoriesFailure({
    required super.selectedDates,
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
