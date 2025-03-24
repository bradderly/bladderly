import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/export/report/widget/export_report_app_bar.dart';
import 'package:bladderly/presentation/feature/export/survey/bloc/export_survey_bloc.dart';
import 'package:bladderly/presentation/feature/export/term/model/export_report_reason_model.dart';
import 'package:bladderly/presentation/feature/export/term/widget/export_survey_check_box_widget.dart';
import 'package:bladderly/presentation/feature/export/term/widget/export_survey_text_field.dart';
import 'package:bladderly/presentation/feature/export/widget/export_stickey_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ExportSurveyView extends StatefulWidget {
  const ExportSurveyView({super.key});

  @override
  State<ExportSurveyView> createState() => _ExportSurveyViewState();
}

class _ExportSurveyViewState extends State<ExportSurveyView> {
  final focusNodeDoctorName = FocusNode(debugLabel: 'DoctorName');
  final focusNodeClinicInformation = FocusNode(debugLabel: 'ClinicInformation');

  @override
  void dispose() {
    focusNodeDoctorName.dispose();
    focusNodeClinicInformation.dispose();
    super.dispose();
  }

  void _completeSurvey(BuildContext context) {
    context
        .read<ExportSurveyBloc>()
        .add(ExportSurveySendReason(userId: context.read<UserBloc>().state.userModelOrThrowException.id));
  }

  void _sendReasonSuccess(BuildContext context, ExportSurveySendReasonSuccess state) {
    context.pop();
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExportSurveyBloc, ExportSurveyState>(
      listener: (context, state) => switch (state) {
        ExportSurveySendReasonInProgress() => ProgressIndicatorModal.show(context),
        ExportSurveySendReasonSuccess() => _sendReasonSuccess(context, state),
        ExportSurveySendReasonFailure() => context.pop(),
        _ => null,
      },
      child: Scaffold(
        appBar: const ExportReportAppBar(),
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView(
                physics: const ClampingScrollPhysics(),
                controller: ModalScrollController.of(context),
                padding: const EdgeInsets.all(24).copyWith(bottom: 140),
                children: [
                  Text(
                    'Data report is sent to your email!'.tr(context),
                    style: context.textStyleTheme.b18SemiBold.copyWith(color: context.colorTheme.neutral.shade9),
                  ),
                  const Gap(19),
                  Text(
                    'Your opinions matter the most. Please share with us the purpose of the data report.'.tr(context),
                    style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade7),
                  ),
                  const Gap(56),
                  BlocSelector<ExportSurveyBloc, ExportSurveyState, ExportReportReasonModel>(
                    selector: (state) => state.reasonModel,
                    builder: (context, reasonModel) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What’s this report for?'.tr(context),
                          style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade9),
                        ),
                        const Gap(24),
                        ExportSurveyCheckBoxWidget(
                          onTap: () => context.read<ExportSurveyBloc>().add(
                              const ExportSurveySelectReason(reasonModel: ExportReportReasonModel.useForPersonal())),
                          isChecked: reasonModel is ExportReportUseForPersonalReason,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 24,
                            child: Text(
                              'For personal use only.'.tr(context),
                              style:
                                  context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade9),
                            ),
                          ),
                        ),
                        const Gap(24),
                        ExportSurveyCheckBoxWidget(
                          onTap: () => context
                              .read<ExportSurveyBloc>()
                              .add(const ExportSurveySelectReason(reasonModel: ExportReportReasonModel.shareClinic())),
                          isChecked: reasonModel is ExportReportShareClinicReason,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 24,
                                child: Text(
                                  'To share with a clinician.'.tr(context),
                                  style: context.textStyleTheme.b16Medium
                                      .copyWith(color: context.colorTheme.neutral.shade9),
                                ),
                              ),
                              if (reasonModel is ExportReportShareClinicReason) ...[
                                const Gap(16),
                                ExportSurveyTextField(
                                  onChanged: (value) => context.read<ExportSurveyBloc>().add(
                                        ExportSurveySelectReason(reasonModel: reasonModel.copyWith(doctorName: value)),
                                      ),
                                  focusNode: focusNodeDoctorName,
                                  onSubmitted: (value) => focusNodeClinicInformation.requestFocus(),
                                  hintText: 'Dr. Name'.tr(context),
                                ),
                                const Gap(8),
                                ExportSurveyTextField(
                                  onChanged: (value) => context.read<ExportSurveyBloc>().add(
                                        ExportSurveySelectReason(
                                          reasonModel: reasonModel.copyWith(clinicInformation: value),
                                        ),
                                      ),
                                  onSubmitted: (value) => FocusScope.of(context).unfocus(),
                                  focusNode: focusNodeClinicInformation,
                                  hintText: 'Clinic Information'.tr(context),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                top: null,
                child: BlocSelector<ExportSurveyBloc, ExportSurveyState, bool>(
                  selector: (state) => state.reasonModel.isValid,
                  builder: (context, isValid) => ExportStickeyButton(
                    onTap: isValid ? () => _completeSurvey(context) : null,
                    text: 'Done'.tr(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
