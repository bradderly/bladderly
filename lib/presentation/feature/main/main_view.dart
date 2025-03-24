// Flutter imports:

// Project imports:

import 'dart:async';

import 'package:bladderly/core/event_analyzer/event_analyzer.dart';
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/domain/exception/domain_exception.dart';
import 'package:bladderly/domain/exception/get_history_result_failure_exception.dart';
import 'package:bladderly/domain/exception/network_not_connected_exception.dart';
import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/presentation/common/bloc/history_result_bloc.dart';
import 'package:bladderly/presentation/common/bloc/membership_bloc.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/cubit/diary_date_cubit.dart';
import 'package:bladderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bladderly/presentation/common/cubit/main_tab_cubit.dart';
import 'package:bladderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bladderly/presentation/common/cubit/timer_cubit.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/common/widget/common_message_modal.dart';
import 'package:bladderly/presentation/feature/diary/diary/diary_builder.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_tab_scroll_section_model.dart';
import 'package:bladderly/presentation/feature/home/home_builder.dart';
import 'package:bladderly/presentation/feature/main/bloc/main_history_bloc.dart';
import 'package:bladderly/presentation/feature/main/modal/get_history_result_failure_modal.dart';
import 'package:bladderly/presentation/feature/main/widget/main_bottom_navigation_bar.dart';
import 'package:bladderly/presentation/feature/payment/bloc/payment_bloc.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

class MainView extends StatefulWidget {
  const MainView({
    super.key,
    required this.recorderFileLoader,
    required this.eventAnalyzer,
  });

  final RecorderFileLoader recorderFileLoader;
  final EventAnalyzer eventAnalyzer;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final pageController = PageController();
  late final userPropertyStream = CombineLatestStream.combine3(
    context.read<UserBloc>().stream.map<UserModel?>((state) => state.userModelOrThrowException).onErrorReturn(null),
    context.read<AppLocaleCubit>().stream,
    context.read<MembershipBloc>().stream.map((state) => state.membership),
    (user, lang, membership) => (user: user, lang: lang, membership: membership),
  );

  late final StreamSubscription<({AppLocale lang, Membership? membership, UserModel? user})> userPropertySubscription;

  @override
  void initState() {
    super.initState();
    userPropertySubscription = userPropertyStream.listen(
      (data) => switch (data.user) {
        final UserModel user => initializeEventAnalyzer(user: user, lang: data.lang, membership: data.membership),
        _ => widget.eventAnalyzer.clearUser(),
      },
    );
    initializeHistories();
    initializePurchaseHandler();
    initilizeMembership();
    initializeEventAnalyzer(
      user: context.read<UserBloc>().state.userModelOrThrowException,
      lang: context.read<AppLocaleCubit>().state,
      membership: context.read<MembershipBloc>().state.membership,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => checkPendingUploadFile());
  }

  @override
  void dispose() {
    userPropertySubscription.cancel();
    widget.eventAnalyzer.clearUser();
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
      final NetworkNotConnectedException exception => showNetworkNotConnectedAlert(exception),
      _ => null,
    };
  }

  void initializeEventAnalyzer({
    required UserModel user,
    required AppLocale lang,
    required Membership? membership,
  }) {
    widget.eventAnalyzer.initializeUser(
      userId: user.id,
      userProperties: {
        'lang': lang.name,
        // TODO(신중석) : 멤버쉽 정보 추가
        // 'membership': membership?.subscription?.name,
      },
    );
  }

  void onMembershipInitializeFailure(BuildContext context, MembershipInitializeFailure state) {
    if (!context.mounted) return;

    if (state.exception case final NetworkNotConnectedException exception
        when !state.isValidMembership && !state.isTodayInitialized) {
      showNetworkNotConnectedAlert(exception);
    }
  }

  void showNetworkNotConnectedAlert(DomainException body) {
    CommonMessageModal.showFromDominException<void>(
      context,
      onTap: context.pop,
      exception: body,
    );
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

        /// 타이머 돌려서 멤버쉽 만료일자에 멤버쉽 재조회
        BlocListener<TimerCubit, DateTime>(
          listenWhen: (prev, curr) {
            final subscription = context.read<MembershipBloc>().state.membership?.subscription;
            return subscription?.validate(curr) != subscription?.validate(prev);
          },
          listener: (context, state) => context
              .read<MembershipBloc>()
              .add(MembershipInitialize(userId: context.read<UserBloc>().state.userModelOrThrowException.id)),
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
                  onPressedMoreVoiding: () => context
                    ..read<DiaryDateCubit>().changeDate(DateTime.now())
                    ..read<MainTabCubit>().showDiary(scrollSection: DiaryTabScrollSectionModel.voiding),
                  onPressedMoreIntake: () => context
                    ..read<DiaryDateCubit>().changeDate(DateTime.now())
                    ..read<MainTabCubit>().showDiary(scrollSection: DiaryTabScrollSectionModel.intake),
                ),
                BlocSelector<MainTabCubit, MainTabState, MainTabDiary?>(
                  selector: (state) => state is MainTabDiary ? state : null,
                  builder: (context, state) => DiaryBuilder(
                    diaryTabScrollSectionModel: state?.diaryTabScrollSectionModel,
                    checkRate: state?.checkRate ?? false,
                  ),
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
