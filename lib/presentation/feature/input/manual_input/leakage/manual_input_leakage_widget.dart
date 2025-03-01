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
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/input/manual_input/leakage/bloc/manual_input_leakage_bloc.dart';
import 'package:bladderly/presentation/feature/input/manual_input/leakage/cubit/manual_input_leakage_form_cubit.dart';
import 'package:bladderly/presentation/feature/input/manual_input/widget/manual_input_leakage_volume_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_field_widget.dart';
import 'package:bladderly/presentation/feature/input/widget/input_save_button.dart';
import 'package:bladderly/presentation/feature/input/widget/input_text_area_widget.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';

class ManualInputLeakageView extends StatefulWidget {
  const ManualInputLeakageView({
    super.key,
    required this.recordTime,
    required this.isEditing,
  });

  final DateTime recordTime;
  final bool isEditing;

  @override
  State<ManualInputLeakageView> createState() => _ManualInputLeakageViewState();
}

class _ManualInputLeakageViewState extends State<ManualInputLeakageView> with AutomaticKeepAliveClientMixin {
  @override
  void didUpdateWidget(covariant ManualInputLeakageView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.recordTime != widget.recordTime) {
      context.read<ManualInputLeakageFormCubit>().setRecordTime(widget.recordTime);
    }
  }

  @override
  bool get wantKeepAlive => true;

  void _onSave(BuildContext context, ManualInputLeakageFormState state) {
    final event = ManualInputLeakageSave(
      userId: context.read<UserBloc>().state.userModelOrThrowException.id,
      id: state.id,
      recordTime: state.recordTime,
      leakageVolume: state.leakageVolume!,
      memo: state.memo,
    );

    context.read<ManualInputLeakageBloc>().add(event);
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

    return BlocListener<ManualInputLeakageBloc, ManualInputLeakageState>(
      listener: (context, state) => switch (state) {
        ManualInputLeakageSaveInProgress() => onSaveInProgress(context),
        ManualInputLeakageSaveSuccess() => onSaveSuccess(context),
        _ => null,
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 24, bottom: 132),
            children: [
              _buildLeakageVolume(context),
              const Gap(48),
              _buildMemo(context),
            ],
          ),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildLeakageVolume(BuildContext context) {
    return InputFieldWidget(
      label: 'Leakage Volume'.tr(context),
      child: BlocSelector<ManualInputLeakageFormCubit, ManualInputLeakageFormState, LeakageVolume?>(
        selector: (state) => state.leakageVolume,
        builder: (context, leakageVolume) => ManualInputLeakageVolumeWidget(
          onChanged: context.read<ManualInputLeakageFormCubit>().setLeakageVolume,
          leakageVolume: leakageVolume,
        ),
      ),
    );
  }

  Widget _buildMemo(BuildContext context) {
    return InputFieldWidget(
      label: 'Memo'.tr(context),
      child: InputTextAreaWidget(
        onChanged: context.read<ManualInputLeakageFormCubit>().setMemo,
        initialValue: context.read<ManualInputLeakageFormCubit>().state.memo,
      ),
    );
  }

  Widget _buildSaveButton() {
    return Positioned.fill(
      top: null,
      bottom: 28,
      child: Center(
        child: BlocBuilder<ManualInputLeakageFormCubit, ManualInputLeakageFormState>(
          builder: (context, state) => InputSaveButton(
            onPressed: state.isValid ? () => _onSave(context, state) : null,
          ),
        ),
      ),
    );
  }
}
