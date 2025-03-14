// Flutter imports:

// Project imports:
import 'package:bladderly/domain/model/leakage_volume.dart';
import 'package:bladderly/presentation/common/bloc/history_result_bloc.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/cubit/main_tab_cubit.dart';
import 'package:bladderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
// Flutter imports:
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/input/sound_input_note/bloc/sound_input_note_bloc.dart';
import 'package:bladderly/presentation/feature/input/sound_input_note/cubit/sound_input_note_form_cubit.dart';
import 'package:bladderly/presentation/feature/input/sound_input_note/modal/sound_input_note_upload_success_modal.dart';
import 'package:bladderly/presentation/feature/input/widget/input_choice_button.dart';
import 'package:bladderly/presentation/feature/input/widget/input_field_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_leakage_volume_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_record_time_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_record_urgency_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_save_button.dart';
import 'package:bladderly/presentation/feature/input/widget/input_text_area_widget.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SoundInputNoteView extends StatelessWidget {
  const SoundInputNoteView({
    super.key,
    required this.recordTime,
  });

  final DateTime recordTime;

  void _onSave(BuildContext context) {
    final state = context.read<SoundInputNoteFormCubit>().state;
    final event = SoundInputNoteUpload(
      userId: _getUserId(context),
      recordTime: recordTime,
      isLeakage: state.isLeakage!,
      leakageVolume: state.leakageVolume,
      isNocutria: state.isNocutria!,
      recordUrgency: state.recordUrgency!,
      memo: state.memo,
    );

    context.read<SoundInputNoteBloc>().add(event);
  }

  void _onSaveSuccess(BuildContext context, SoundInputUploadSuccess state) {
    context.pop();

    context.read<PendingUploadFileCubit>().clearRecordTime();
    context.read<HistoryResultBloc>().add(HistoryResultGet(userId: _getUserId(context), historyId: state.historyId));

    SoundInputNoteUploadSuccessModal.show(
      context,
      onGoToDiary: () => const MainRoute().go(context..read<MainTabCubit>().showDiary()),
    );
  }

  void _onSoundInputNoteBlocListener(BuildContext context, SoundInputNoteState state) {
    return switch (state) {
      SoundInputUploadInProgress() => ProgressIndicatorModal.show(context),
      SoundInputUploadSuccess() => _onSaveSuccess(context, state),
      SoundInputUploadFailure() => context.pop(),
      _ => null,
    };
  }

  String _getUserId(BuildContext context) {
    return context.read<UserBloc>().state.userModelOrThrowException.id;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SoundInputNoteBloc, SoundInputNoteState>(
      listener: _onSoundInputNoteBlocListener,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {},
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 58,
            title: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: InputRecordTimeWidget(dateTime: recordTime),
            ),
          ),
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 24, bottom: 132),
                  children: [
                    _buildVolume(context),
                    const Gap(48),
                    _buildUrgency(context),
                    const Gap(48),
                    _buildNocturia(context),
                    const Gap(48),
                    _buildLeakage(context),
                    BlocSelector<SoundInputNoteFormCubit, SoundInputNoteFormState, bool?>(
                      selector: (state) => state.isLeakage,
                      builder: (context, isLeakage) =>
                          isLeakage != true ? const SizedBox.shrink() : _buildLeakageVolume(context),
                    ),
                    const Gap(48),
                    _buildMemo(context),
                  ],
                ),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVolume(BuildContext context) {
    return InputFieldWidget(
      label: 'Voided volume'.tr(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24).copyWith(left: 19, right: 22),
        decoration: BoxDecoration(
          color: context.colorTheme.vermilion.secondary.shade5,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recording saved!'.tr(context),
                    style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
                  ),
                  const Gap(10.5),
                  Text(
                    'Recording save Message'.tr(context).applyWordBreak(),
                    style: context.textStyleTheme.b14Medium.copyWith(
                      color: context.colorTheme.neutral.shade7,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(25),
            Assets.icon.icInputRecordingDone.svg(),
          ],
        ),
      ),
    );
  }

  Widget _buildUrgency(BuildContext context) {
    return InputFieldWidget(
      label: 'Select urge level'.tr(context),
      child: BlocSelector<SoundInputNoteFormCubit, SoundInputNoteFormState, int?>(
        selector: (state) => state.recordUrgency,
        builder: (context, level) => InputRecordUrgencyWidget(
          onTap: context.read<SoundInputNoteFormCubit>().setLevel,
          recordUrgency: level,
        ),
      ),
    );
  }

  Widget _buildNocturia(BuildContext context) {
    return InputFieldWidget(
      label: 'Was it an urination during sleep?'.tr(context),
      child: BlocSelector<SoundInputNoteFormCubit, SoundInputNoteFormState, bool?>(
        selector: (state) => state.isNocutria,
        builder: (context, isNocutria) => InputChoiceButton(
          onTap: context.read<SoundInputNoteFormCubit>().setIsNocutria,
          value: isNocutria,
        ),
      ),
    );
  }

  Widget _buildLeakage(BuildContext context) {
    return InputFieldWidget(
      label: 'Did it leak?'.tr(context),
      child: BlocSelector<SoundInputNoteFormCubit, SoundInputNoteFormState, bool?>(
        selector: (state) => state.isLeakage,
        builder: (context, isLeakage) => InputChoiceButton(
          onTap: context.read<SoundInputNoteFormCubit>().setIsLeakage,
          value: isLeakage,
        ),
      ),
    );
  }

  Widget _buildLeakageVolume(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(48),
        InputFieldWidget(
          label: 'Leakage Volume'.tr(context),
          child: BlocSelector<SoundInputNoteFormCubit, SoundInputNoteFormState, LeakageVolume?>(
            selector: (state) => state.leakageVolume,
            builder: (context, leakageVolume) => InputLeakageVolumeWidget(
              onChanged: context.read<SoundInputNoteFormCubit>().setLeakageVolume,
              leakageVolume: leakageVolume,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMemo(BuildContext context) {
    return InputFieldWidget(
      label: 'Memo'.tr(context),
      child: InputTextAreaWidget(
        onChanged: context.read<SoundInputNoteFormCubit>().setMemo,
        initialValue: context.read<SoundInputNoteFormCubit>().state.memo,
      ),
    );
  }

  Widget _buildSaveButton() {
    return Positioned.fill(
      top: null,
      bottom: 28,
      child: Center(
        child: BlocSelector<SoundInputNoteFormCubit, SoundInputNoteFormState, bool>(
          selector: (state) => state.isValid,
          builder: (context, isValid) => InputSaveButton(
            onPressed: isValid ? () => _onSave(context) : null,
          ),
        ),
      ),
    );
  }
}
