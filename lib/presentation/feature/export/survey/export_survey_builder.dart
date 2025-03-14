import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/send_histories_export_reason_usecase.dart';
import 'package:bladderly/presentation/feature/export/survey/bloc/export_survey_bloc.dart';
import 'package:bladderly/presentation/feature/export/survey/export_survey_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExportSurveyBuilder extends StatelessWidget {
  const ExportSurveyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExportSurveyBloc>(
      create: (_) => ExportSurveyBloc(
        sendHistoriesExportReasonUsecase: getIt<SendHistoriesExportReasonUsecase>(),
      ),
      child: const ExportSurveyView(),
    );
  }
}
