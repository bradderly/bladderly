import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/domain/usecase/export_histories_usecase.dart';
import 'package:bradderly/presentation/feature/export/term/bloc/export_bloc.dart';
import 'package:bradderly/presentation/feature/export/term/export_term_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExportTermBuilder extends StatelessWidget {
  const ExportTermBuilder({
    super.key,
    required this.onExport,
    required this.dates,
    required this.email,
  });

  final VoidCallback onExport;
  final List<DateTime> dates;

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExportBloc>(
      create: (_) => ExportBloc(exportHistoriesUsecase: getIt<ExportHistoriesUsecase>()),
      child: ExportTermView(
        onExport: onExport,
        dates: dates,
        email: email,
      ),
    );
  }
}
