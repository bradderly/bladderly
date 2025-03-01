// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bladderly/domain/model/leakage_volume.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_keyboard_actions.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/input/manual_input/voiding/bloc/manual_input_voiding_bloc.dart';
import 'package:bladderly/presentation/feature/input/manual_input/voiding/cubit/manual_input_voiding_form_cubit.dart';
import 'package:bladderly/presentation/feature/input/manual_input/voiding/widget/manual_input_voiding_volume_widget.dart';
import 'package:bladderly/presentation/feature/input/manual_input/widget/manual_input_leakage_volume_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_choice_button.dart';
import 'package:bladderly/presentation/feature/input/widget/input_field_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_record_urgency_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_save_button.dart';
import 'package:bladderly/presentation/feature/input/widget/input_text_area_widget.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';

class ManualInputVoidingWidget extends StatefulWidget {
  const ManualInputVoidingWidget({
    super.key,
    required this.recordTime,
    required this.isEditing,
  });

  final DateTime recordTime;
  final bool isEditing;

  @override
  State<ManualInputVoidingWidget> createState() => _ManualInputVoidingWidgetState();
}

class _ManualInputVoidingWidgetState extends State<ManualInputVoidingWidget> with AutomaticKeepAliveClientMixin {
  final recordVolumeFocusNode = FocusNode(debugLabel: 'recordVolume');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => recordVolumeFocusNode.requestFocus());
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ManualInputVoidingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.recordTime != widget.recordTime) {
      context.read<ManualInputVoidingFormCubit>().setRecordTime(widget.recordTime);
    }
  }

  @override
  void dispose() {
    recordVolumeFocusNode.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void _onSave(BuildContext context, ManualInputVoidingFormState state) {
    final event = ManualInputVoidingSave(
      userId: context.read<UserBloc>().state.userModelOrThrowException.id,
      id: state.id,
      recordTime: state.recordTime,
      recordVolume: state.unit.parseToMl(int.parse(state.recordVolume)),
      recordUrgency: state.recordUrgency!,
      isNocutria: state.isNocutria!,
      isLeakage: state.isLeakage!,
      leakageVolume: state.leakageVolume,
      memo: state.memo,
    );

    context.read<ManualInputVoidingBloc>().add(event);
  }

  Future<void> onSaveInProgress(BuildContext context) {
    return ProgressIndicatorModal.show(context);
  }

  void onSaveSuccess(BuildContext context) {
    context.pop();

    if (widget.isEditing) {
      return context.pop();
    } else {
      return const MainRoute(tab: MainRouteTab.diary).go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<ManualInputVoidingBloc, ManualInputVoidingState>(
      listener: (context, state) => switch (state) {
        ManualInputVoidingSaveInProgress() => ProgressIndicatorModal.show(context),
        ManualInputVoidingSaveSuccess() => onSaveSuccess(context),
        _ => null,
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          CommonKeyboardActions(
            focusNode: recordVolumeFocusNode,
            child: ListView(
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
      ),
    );
  }

  Widget _buildVolume(BuildContext context) {
    return InputFieldWidget(
      label: 'Voided volume'.tr(context),
      child: BlocBuilder<ManualInputVoidingFormCubit, ManualInputVoidingFormState>(
        buildWhen: (prev, curr) => prev.recordVolume != curr.recordVolume || prev.unit != curr.unit,
        builder: (context, state) => ManualInputVoidingVolumeWidget(
          onChangedAmount: context.read<ManualInputVoidingFormCubit>().setrecordVolume,
          onChangedUnit: context.read<ManualInputVoidingFormCubit>().setUnit,
          focusNode: recordVolumeFocusNode,
          amount: state.recordVolume,
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
        initialValue: context.read<ManualInputVoidingFormCubit>().state.memo,
      ),
    );
  }

  Widget _buildSaveButton() {
    return Positioned.fill(
      top: null,
      bottom: 28,
      child: Center(
        child: BlocBuilder<ManualInputVoidingFormCubit, ManualInputVoidingFormState>(
          builder: (context, state) => InputSaveButton(
            onPressed: state.isValid ? () => _onSave(context, state) : null,
          ),
        ),
      ),
    );
  }

  //   Widget _buildSaveButton() {
  //   return ListenableBuilder(
  //     listenable: recordVolumeFocusNode,
  //     builder: (context, child) => Positioned.fill(
  //       top: null,
  //       bottom: 28 + (recordVolumeFocusNode.hasFocus ? 51 : 0),
  //       child: child!,
  //     ),
  //     child: Center(
  //       child: BlocBuilder<ManualInputVoidingFormCubit, ManualInputVoidingFormState>(
  //         buildWhen: (prev, curr) => prev.isValid != curr.isValid,
  //         builder: (context, state) => InputSaveButton(
  //           onPressed: state.isValid ? () => _onSave(context, state) : null,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
