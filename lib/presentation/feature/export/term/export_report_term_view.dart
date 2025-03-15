// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/email_address_input_field.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/export/term/bloc/export_bloc.dart';
import 'package:bladderly/presentation/feature/export/widget/export_stickey_button.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ExportReportTermView extends StatefulWidget {
  const ExportReportTermView({
    super.key,
    required this.onExportSuccess,
    required this.selectedDates,
  });

  final VoidCallback onExportSuccess;
  final List<DateTime> selectedDates;

  @override
  State<ExportReportTermView> createState() => _ExportReportTermViewState();
}

class _ExportReportTermViewState extends State<ExportReportTermView> {
  String email = '';

  void _export() {
    final userId = context.read<UserBloc>().state.userModelOrThrowException.id;

    context.read<ExportBloc>().add(ExportExportHistories(userId: userId, email: email, dates: widget.selectedDates));
  }

  void _onExportSuccess(BuildContext context, ExportExportHistoriesSuccess state) {
    context.pop();
    widget.onExportSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExportBloc, ExportState>(
      listener: (context, state) => switch (state) {
        ExportExportHistoriesInProgress() => ProgressIndicatorModal.show(context),
        ExportExportHistoriesSuccess() => _onExportSuccess(context, state),
        ExportExportHistoriesFailure() => context.pop(),
        _ => null,
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            controller: ModalScrollController.of(context),
            padding: const EdgeInsets.all(24).copyWith(bottom: 140),
            children: [
              Text(
                'Selected data will be sent to'.tr(context),
                style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade8),
              ),
              const Gap(8),
              EmailAddressInputField(
                onChanged: (value) => setState(() => email = value),
                email: email,
              ),
              const Gap(32),
              Text(
                'Please check your inbox.'.tr(context),
                style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade8),
              ),
              const Gap(8),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Share policy Message'.tr(context),
                  style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade7),
                ),
              ),
            ],
          ),
          Positioned.fill(
            top: null,
            child: ExportStickeyButton(
              onTap: email.validateEmail() ? _export : null,
              text: 'Agree and Export'.tr(context),
            ),
          ),
        ],
      ),
    );
  }
}
