import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/export/report/bloc/export_report_bloc.dart';
import 'package:bradderly/presentation/feature/export/report/model/export_report_reason_model.dart';
import 'package:bradderly/presentation/feature/export/report/widget/export_report_app_bar.dart';
import 'package:bradderly/presentation/feature/export/report/widget/export_report_check_box_widget.dart';
import 'package:bradderly/presentation/feature/export/report/widget/export_report_text_field.dart';
import 'package:bradderly/presentation/feature/export/widget/export_stickey_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ExportReportView extends StatefulWidget {
  const ExportReportView({super.key});

  @override
  State<ExportReportView> createState() => _ExportReportViewState();
}

class _ExportReportViewState extends State<ExportReportView> {
  final focusNodeDoctorName = FocusNode(debugLabel: 'DoctorName');
  final focusNodeClinicInformation = FocusNode(debugLabel: 'ClinicInformation');

  @override
  void dispose() {
    focusNodeDoctorName.dispose();
    focusNodeClinicInformation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ExportReportAppBar(),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ListView(
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
                BlocSelector<ExportReportBloc, ExportReportState, ExportReportReasonModel>(
                  selector: (state) => state.reasonModel,
                  builder: (context, reasonModel) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What’s this report for?'.tr(context),
                        style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade9),
                      ),
                      const Gap(24),
                      ExportReportCheckBoxWidget(
                        onTap: () => context
                            .read<ExportReportBloc>()
                            .add(const ExportReportSelectReason(reasonModel: ExportReportReasonModel.useForPersonal())),
                        isChecked: reasonModel is ExportReportUseForPersonalReason,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 24,
                          child: Text(
                            'For personal use only.'.tr(context),
                            style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade9),
                          ),
                        ),
                      ),
                      const Gap(24),
                      ExportReportCheckBoxWidget(
                        onTap: () => context
                            .read<ExportReportBloc>()
                            .add(const ExportReportSelectReason(reasonModel: ExportReportReasonModel.shareClinic())),
                        isChecked: reasonModel is ExportReportShareClinicReason,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 24,
                              child: Text(
                                'To share with a clinician.'.tr(context),
                                style:
                                    context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade9),
                              ),
                            ),
                            if (reasonModel is ExportReportShareClinicReason) ...[
                              const Gap(16),
                              ExportReportTextField(
                                onChanged: (value) => context.read<ExportReportBloc>().add(
                                      ExportReportSelectReason(reasonModel: reasonModel.copyWith(doctorName: value)),
                                    ),
                                focusNode: focusNodeDoctorName,
                                onSubmitted: (value) => focusNodeClinicInformation.requestFocus(),
                                hintText: 'Dr. Name'.tr(context),
                              ),
                              const Gap(8),
                              ExportReportTextField(
                                onChanged: (value) => context.read<ExportReportBloc>().add(
                                      ExportReportSelectReason(
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
              child: BlocSelector<ExportReportBloc, ExportReportState, bool>(
                selector: (state) => state.reasonModel.isValid,
                builder: (context, isValid) => ExportStickeyButton(
                  onTap: isValid
                      ? () => context
                          .read<ExportReportBloc>()
                          .add(const ExportReportSendReason(hashId: 'ydu3328@naver.com'))
                      : null,
                  text: 'Done'.tr(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
