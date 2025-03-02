// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/export_histories_usecase.dart';
import 'package:bladderly/presentation/feature/export/export_view.dart';
import 'package:bladderly/presentation/feature/export/term/bloc/export_bloc.dart';

class ExportBuilder extends StatelessWidget {
  const ExportBuilder({
    super.key,
    required this.historyDates,
  });

  final List<DateTime> historyDates;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExportBloc>(
      create: (_) => ExportBloc(exportHistoriesUsecase: getIt<ExportHistoriesUsecase>()),
      child: ExportView(
        historyDates: historyDates,
      ),
    );
  }
}
