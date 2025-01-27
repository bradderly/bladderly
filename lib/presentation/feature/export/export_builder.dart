import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/domain/usecase/export_histories_usecase.dart';
import 'package:bradderly/presentation/feature/export/export_view.dart';
import 'package:bradderly/presentation/feature/export/term/bloc/export_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExportBuilder extends StatelessWidget {
  const ExportBuilder({
    super.key,
    required this.historyDates,
  });

  final List<DateTime> historyDates;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExportBloc(exportHistoriesUsecase: getIt<ExportHistoriesUsecase>()),
      child: ExportView(
        historyDates: historyDates,
      ),
    );
  }
}
