part of 'export_bloc.dart';

sealed class ExportState extends Equatable {
  const ExportState();

  @override
  List<Object?> get props => [];
}

final class ExportInitial extends ExportState {
  const ExportInitial();
}

final class ExportExportHistoriesInProgress extends ExportState {
  const ExportExportHistoriesInProgress();
}

final class ExportExportHistoriesSuccess extends ExportState {
  const ExportExportHistoriesSuccess();
}

final class ExportExportHistoriesFailure extends ExportState {
  const ExportExportHistoriesFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object?> get props => [
        ...super.props,
        exception,
      ];
}
