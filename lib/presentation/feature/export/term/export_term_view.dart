// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/export/term/bloc/export_bloc.dart';
import 'package:bladderly/presentation/feature/export/term/widget/export_term_app_bar.dart';
import 'package:bladderly/presentation/feature/export/widget/export_stickey_button.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ExportTermView extends StatelessWidget {
  const ExportTermView({
    super.key,
    required this.onExport,
    required this.dates,
  });

  final VoidCallback onExport;
  final List<DateTime> dates;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExportBloc, ExportState>(
      listener: (context, state) => switch (state) {
        ExportExportHistoriesInProgress() => ProgressIndicatorModal.show(context),
        ExportExportHistoriesSuccess() => Navigator.of(context).pop<void>(onExport()),
        ExportExportHistoriesFailure() => Navigator.of(context).pop<void>(),
        _ => null,
      },
      child: Scaffold(
        appBar: const ExportTermAppBar(),
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView(
                padding: const EdgeInsets.all(24).copyWith(bottom: 140),
                children: [
                  Text(
                    'Selected data will be sent to'.tr(context),
                    style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade8),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Assets.icon.icExportEmail.svg(),
                      const Gap(8),
                      Text(
                        'email',
                        style: context.textStyleTheme.b18SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    'Please check your inbox.'.tr(context),
                    style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade8),
                  ),
                  const Gap(32),
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
                  onTap: () => context.read<ExportBloc>().add(
                        ExportExportHistories(
                          userId: context.read<UserBloc>().state.userModelOrThrowException.id,
                          email: 'email',
                          dates: dates,
                        ),
                      ),
                  text: 'Agree and Export'.tr(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
