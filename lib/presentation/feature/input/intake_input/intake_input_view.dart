import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_keyboard_actions.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/input/intake_input/bloc/intake_input_bloc.dart';
import 'package:bladderly/presentation/feature/input/intake_input/cubit/intake_input_form_cubit.dart';
import 'package:bladderly/presentation/feature/input/intake_input/model/intake_input_beverage_model.dart';
import 'package:bladderly/presentation/feature/input/intake_input/widget/intake_input_beverage_type_widget.dart';
import 'package:bladderly/presentation/feature/input/intake_input/widget/intake_input_record_volume_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_field_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_record_time_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_save_button.dart';
import 'package:bladderly/presentation/feature/input/widget/input_text_area_widget.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class IntakeInputView extends StatefulWidget {
  const IntakeInputView({
    super.key,
    required this.isEditing,
  });

  final bool isEditing;

  @override
  State<IntakeInputView> createState() => _IntakeInputViewState();
}

class _IntakeInputViewState extends State<IntakeInputView> {
  final recordVolumeFocusNode = FocusNode(debugLabel: 'recordVolumeFocusNode');

  @override
  void dispose() {
    recordVolumeFocusNode.dispose();
    super.dispose();
  }

  void _onSave(BuildContext context, IntakeInputFormState state) {
    final event = IntakeInputSave(
      id: state.id,
      hashId: 'ydu3328@naver.com',
      recordTime: state.recordTime,
      beverageType: state.beverageModel!.value,
      recordVolume: state.recordVolumeModel!.volume,
      memo: state.memo,
    );

    context.read<IntakeInputBloc>().add(event);
  }

  void _onSaveSuccess(BuildContext context) {
    context.pop();

    if (widget.isEditing) {
      return context.pop();
    } else {
      return const MainRoute(tab: MainRouteTab.diary).go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntakeInputBloc, IntakeInputState>(
      listener: (context, state) => switch (state) {
        IntakeInputSaveInProgress() => ProgressIndicatorModal.show(context),
        IntakeInputSaveSuccess() => _onSaveSuccess(context),
        _ => null,
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 58,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(left: 26, top: 18),
            child: InputRecordTimeWidget(
              onChanged: context.read<IntakeInputFormCubit>().setRecordTime,
              dateTime: context.read<IntakeInputFormCubit>().state.recordTime,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: Navigator.of(context).pop,
              child: Assets.icon.icExportClose.svg(
                colorFilter: ColorFilter.mode(
                  context.colorTheme.neutral.shade8,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const Gap(16),
          ],
        ),
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              CommonKeyboardActions(
                focusNode: recordVolumeFocusNode,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 24, bottom: 132),
                  children: [
                    InputFieldWidget(
                      label: 'Beverage type'.tr(context),
                      child: BlocSelector<IntakeInputFormCubit, IntakeInputFormState, IntakeInputBeverageModel?>(
                        selector: (state) => state.beverageModel,
                        builder: (context, beverageModel) => IntakeInputBeverageTypeWidget(
                          onChanged: context.read<IntakeInputFormCubit>().setBeverageModel,
                          beverageModel: beverageModel,
                        ),
                      ),
                    ),
                    const Gap(48),
                    InputFieldWidget(
                      label: 'How much did you drink?'.tr(context),
                      child: BlocBuilder<IntakeInputFormCubit, IntakeInputFormState>(
                        buildWhen: (prev, curr) =>
                            prev.recordVolumeModel != curr.recordVolumeModel || prev.unit != curr.unit,
                        builder: (context, state) => IntakeInputRecordVolumeWidget(
                          focusNode: recordVolumeFocusNode,
                          onChangedVolume: context.read<IntakeInputFormCubit>().setRecordVolumeModel,
                          onChangedUnit: context.read<IntakeInputFormCubit>().setUnit,
                          recordVolumeModel: state.recordVolumeModel,
                          unit: state.unit,
                        ),
                      ),
                    ),
                    const Gap(48),
                    InputFieldWidget(
                      label: 'Memo'.tr(context),
                      child: InputTextAreaWidget(
                        onChanged: context.read<IntakeInputFormCubit>().setMemo,
                        initialValue: context.read<IntakeInputFormCubit>().state.memo,
                      ),
                    ),
                  ],
                ),
              ),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Positioned.fill(
      top: null,
      bottom: 28,
      child: Center(
        child: BlocBuilder<IntakeInputFormCubit, IntakeInputFormState>(
          builder: (context, state) => InputSaveButton(
            onPressed: state.isValid ? () => _onSave(context, state) : null,
          ),
        ),
      ),
    );
  }
}
