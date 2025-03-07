// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/export_histories_usecase.dart';
import 'package:bladderly/presentation/feature/export/term/bloc/export_bloc.dart';
import 'package:bladderly/presentation/feature/export/term/export_term_view.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class ExportTermBuilder extends StatelessWidget {
  const ExportTermBuilder({
    super.key,
    required this.onExport,
    required this.dates,
  });

  final VoidCallback onExport;
  final List<DateTime> dates;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExportBloc>(
      create: (_) => ExportBloc(exportHistoriesUsecase: getIt<ExportHistoriesUsecase>()),
      child: ExportTermView(
        onExport: onExport,
        dates: dates,
      ),
    );
  }
}
