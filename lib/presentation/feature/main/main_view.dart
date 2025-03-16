// Flutter imports:

// Project imports:

import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/domain/exception/get_history_result_failure_exception.dart';
import 'package:bladderly/domain/exception/network_not_connected_exception.dart';
import 'package:bladderly/presentation/common/bloc/history_result_bloc.dart';
import 'package:bladderly/presentation/common/bloc/membership_bloc.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/cubit/main_tab_cubit.dart';
import 'package:bladderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bladderly/presentation/common/widget/common_error_modal.dart';
import 'package:bladderly/presentation/common/widget/get_history_result_failure_modal.dart';
import 'package:bladderly/presentation/feature/diary/diary/diary_builder.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_tab_scroll_section_model.dart';
import 'package:bladderly/presentation/feature/home/home_builder.dart';
import 'package:bladderly/presentation/feature/main/bloc/main_history_bloc.dart';
import 'package:bladderly/presentation/feature/main/widget/main_bottom_navigation_bar.dart';
import 'package:bladderly/presentation/feature/payment/bloc/payment_bloc.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatefulWidget {
  const MainView({
    super.key,
    required this.recorderFileLoader,
  });

  final RecorderFileLoader recorderFileLoader;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final pageController = PageController();

  @override
  void initState() {
    super.initState();

    initializeHistories();
    initializePurchaseHandler();
    initilizeMembership();

    WidgetsBinding.instance.addPostFrameCallback((_) => checkPendingUploadFile());
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void checkPendingUploadFile() {
    final recordTime = context.read<PendingUploadFileCubit>().state.recordTime;

    if (recordTime == null) return;

    final file = widget.recorderFileLoader.getFile(recordTime);

    if (file.existsSync()) {
      SoundInputNoteRoute(recordTime: recordTime).push<void>(context);
    }
  }

  void initializeHistories() {
    uploadPendingHistories();
    getProcessingHistoryResults();
  }

  void uploadPendingHistories() {
    if (!mounted) return;

    final userId = context.read<UserBloc>().state.userModelOrThrowException.id;

    context.read<MainHistoryBloc>().add(MainHistoryUploadPendingHistories(userId: userId));
  }

  void getProcessingHistoryResults() {
    if (!mounted) return;

    final userId = context.read<UserBloc>().state.userModelOrThrowException.id;

    context.read<MainHistoryBloc>().add(MainHistoryGetHistoryResults(userId: userId));
  }

  void initializePurchaseHandler() {
    if (!mounted) return;

    final userId = context.read<UserBloc>().state.userModelOrThrowException.id;

    context.read<PaymentBloc>().add(PaymentInitializeHandler(userId: userId));
  }

  void initilizeMembership() {
    context.read<MembershipBloc>()
      ..add(MembershipLoad(userId: context.read<UserBloc>().state.userModelOrThrowException.id))
      ..add(MembershipInitialize(userId: context.read<UserBloc>().state.userModelOrThrowException.id));
  }

  Future<void> onHistoryResultGetFailure(BuildContext context, HistoryResultGetFailure state) async {
    if (!context.mounted) return;
    return switch (state.exception) {
      final GetHistoryResultFailureException exception => GetHistoryResultFailureModal.show(
          context,
          onEdit: () => ManualInputRoute(recordTime: exception.recordTime).go(context..pop()),
          onMaintain: context.pop,
          message: exception.message,
          recordTime: exception.recordTime,
        ),
      final NetworkNotConnectedException exception => CommonErrorModal.showFromDominException<void>(
          context,
          onTap: context.pop,
          exception: exception,
        ),
      _ => null,
    };
  }

  void onMembershipInitializeFailure(BuildContext context, MembershipInitializeFailure state) {
    if (!context.mounted) return;

    if (state.exception case final NetworkNotConnectedException exception) {
      CommonErrorModal.showFromDominException<void>(
        context,
        onTap: context.pop,
        exception: exception,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MainTabCubit, MainTabState>(
          listenWhen: (prev, curr) => prev.index != curr.index,
          listener: (context, state) => pageController.jumpToPage(state.index),
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) => switch (state) {
            UserInitial() => const IntroRoute().go(context),
            _ => null,
          },
        ),
        BlocListener<HistoryResultBloc, HistoryResultState>(
          listener: (context, state) => switch (state) {
            HistoryResultGetFailure() => onHistoryResultGetFailure(context, state),
            _ => null,
          },
        ),
        BlocListener<MembershipBloc, MembershipState>(
          listener: (context, state) => switch (state) {
            MembershipInitializeFailure() => onMembershipInitializeFailure(context, state),
            _ => null,
          },
        ),
      ],
      child: Stack(
        fit: StackFit.expand,
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                HomeBuilder(
                  onPressedMoreVoiding: () =>
                      context.read<MainTabCubit>().showDiary(scrollSection: DiaryTabScrollSectionModel.voiding),
                  onPressedMoreIntake: () =>
                      context.read<MainTabCubit>().showDiary(scrollSection: DiaryTabScrollSectionModel.intake),
                ),
                BlocSelector<MainTabCubit, MainTabState, DiaryTabScrollSectionModel?>(
                  selector: (state) => state is MainTabDiary ? state.diaryTabScrollSectionModel : null,
                  builder: (context, diaryTabScrollSectionModel) =>
                      DiaryBuilder(diaryTabScrollSectionModel: diaryTabScrollSectionModel),
                ),
              ],
            ),
            bottomNavigationBar: BlocBuilder<MainTabCubit, MainTabState>(
              builder: (context, state) => MainBottomNavigationBar(
                onTap: context.read<MainTabCubit>().showIndex,
                currentIndex: state.index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
