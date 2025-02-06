import 'package:bradderly/domain/model/leakage_volume.dart';
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/input/manual_input/voiding/cubit/manual_input_voiding_form_cubit.dart';
import 'package:bradderly/presentation/feature/input/manual_input/voiding/widget/manual_input_voiding_volume_widget.dart';
import 'package:bradderly/presentation/feature/input/manual_input/widget/manual_input_leakage_volume_widget.dart';
import 'package:bradderly/presentation/feature/input/widget/input_choice_button.dart';
import 'package:bradderly/presentation/feature/input/widget/input_field_widget.dart';
import 'package:bradderly/presentation/feature/input/widget/input_record_urgency_widget.dart';
import 'package:bradderly/presentation/feature/input/widget/input_save_button.dart';
import 'package:bradderly/presentation/feature/input/widget/input_text_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class ManualInputVoidingWidget extends StatefulWidget {
  const ManualInputVoidingWidget({
    super.key,
    required this.recordTime,
  });

  final DateTime recordTime;

  @override
  State<ManualInputVoidingWidget> createState() => _ManualInputVoidingWidgetState();
}

class _ManualInputVoidingWidgetState extends State<ManualInputVoidingWidget> with AutomaticKeepAliveClientMixin {
  final recordVolumeFocusNode = FocusNode(debugLabel: 'recordVolume');
  final scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => recordVolumeFocusNode.requestFocus());
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    recordVolumeFocusNode.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void _onSave(BuildContext context, ManualInputVoidingFormState state) {
    // final event = SoundInputNoteUpload(
    //   hashId: 'ydu3328@naver.com',
    //   file: recorder.getFile(recorderFile),
    //   recordTime: recorderFile.recordTime,
    //   isLeakage: state.isLeakage!,
    //   isNocutria: state.isNocutria!,
    //   recordUrgency: state.recordUrgency!,
    //   memo: state.memo,
    // );

    // context.read<SoundInputNoteBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        KeyboardActions(
          config: KeyboardActionsConfig(
            keyboardBarColor: const Color(0xFFD1D5DB),
            keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
            nextFocus: false,
            actions: [
              KeyboardActionsItem(
                focusNode: recordVolumeFocusNode,
                displayDoneButton: false,
                displayActionBar: false,
                footerBuilder: (context) => PreferredSize(
                  preferredSize: const Size.fromHeight(51),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Done'.tr(context),
                          style: context.textStyleTheme.b16SemiBold
                              .copyWith(color: context.colorTheme.vermilion.primary.shade50),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 24, bottom: 132),
            children: [
              _buildVolume(context),
              const Gap(48),
              _buildUrgency(context),
              const Gap(48),
              _buildNocturia(context),
              const Gap(48),
              _buildLeakage(context),
              BlocSelector<ManualInputVoidingFormCubit, ManualInputVoidingFormState, bool?>(
                selector: (state) => state.isLeakage,
                builder: (context, isLeakage) =>
                    isLeakage != true ? const SizedBox.shrink() : _buildLeakageVolume(context),
              ),
              const Gap(48),
              _buildMemo(context),
            ],
          ),
        ),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildVolume(BuildContext context) {
    return InputFieldWidget(
      label: 'Voided volume'.tr(context),
      child: BlocBuilder<ManualInputVoidingFormCubit, ManualInputVoidingFormState>(
        buildWhen: (prev, curr) => prev.recordAmount != curr.recordAmount || prev.unit != curr.unit,
        builder: (context, state) => ManualInputVoidingVolumeWidget(
          onChangedAmount: context.read<ManualInputVoidingFormCubit>().setRecordAmount,
          onChangedUnit: context.read<ManualInputVoidingFormCubit>().setUnit,
          focusNode: recordVolumeFocusNode,
          amount: state.recordAmount,
          unit: state.unit,
        ),
      ),
    );
  }

  Widget _buildUrgency(BuildContext context) {
    return InputFieldWidget(
      label: 'Select urge level'.tr(context),
      child: BlocSelector<ManualInputVoidingFormCubit, ManualInputVoidingFormState, int?>(
        selector: (state) => state.recordUrgency,
        builder: (context, level) => InputRecordUrgencyWidget(
          onTap: context.read<ManualInputVoidingFormCubit>().setLevel,
          recordUrgency: level,
        ),
      ),
    );
  }

  Widget _buildNocturia(BuildContext context) {
    return InputFieldWidget(
      label: 'Was it an urination during sleep?'.tr(context),
      child: BlocSelector<ManualInputVoidingFormCubit, ManualInputVoidingFormState, bool?>(
        selector: (state) => state.isNocutria,
        builder: (context, isNocutria) => InputChoiceButton(
          onTap: context.read<ManualInputVoidingFormCubit>().setIsNocutria,
          value: isNocutria,
        ),
      ),
    );
  }

  Widget _buildLeakage(BuildContext context) {
    return InputFieldWidget(
      label: 'Did it leak?'.tr(context),
      child: BlocSelector<ManualInputVoidingFormCubit, ManualInputVoidingFormState, bool?>(
        selector: (state) => state.isLeakage,
        builder: (context, isLeakage) => InputChoiceButton(
          onTap: context.read<ManualInputVoidingFormCubit>().setIsLeakage,
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
          child: BlocSelector<ManualInputVoidingFormCubit, ManualInputVoidingFormState, LeakageVolume?>(
            selector: (state) => state.leakageVolume,
            builder: (context, leakageVolume) => ManualInputLeakageVolumeWidget(
              onChanged: context.read<ManualInputVoidingFormCubit>().setLeakageVolume,
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
        onChanged: context.read<ManualInputVoidingFormCubit>().setMemo,
      ),
    );
  }

  Widget _buildSaveButton() {
    return Positioned.fill(
      top: null,
      bottom: 28,
      child: Center(
        child: BlocBuilder<ManualInputVoidingFormCubit, ManualInputVoidingFormState>(
          buildWhen: (prev, curr) => prev.isValid != curr.isValid,
          builder: (context, state) => InputSaveButton(
            onPressed: state.isValid ? () => _onSave(context, state) : null,
          ),
        ),
      ),
    );
  }
}
