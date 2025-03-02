// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bladderly/presentation/feature/diary/diary/diary_builder.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_tab_scroll_section_model.dart';
import 'package:bladderly/presentation/feature/main/bloc/main_pending_history_bloc.dart';
import 'package:bladderly/presentation/feature/main/cubit/main_tab_cubit.dart';
import 'package:bladderly/presentation/feature/main/home/home_builder.dart';
import 'package:bladderly/presentation/feature/main/widget/main_bottom_navigation_bar.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';

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
    GoRouter.of(context).routeInformationProvider.addListener(routeInfomationProviderListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkPendingUploadFile();
      uploadPendingHistory();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void routeInfomationProviderListener() {
    if (!mounted) return;

    final queryParameters = GoRouter.of(context).state?.uri.queryParametersAll;

    if (queryParameters?['tab']?.firstOrNull case final String tab) {
      context.read<MainTabCubit>().switchByTabName(tab);
    }
  }

  void checkPendingUploadFile() {
    final recorderFile = context.read<PendingUploadFileCubit>().state.recorderFile;

    if (recorderFile == null) return;

    final file = widget.recorderFileLoader.getFile(recorderFile);

    if (file.existsSync()) {
      final extra = SoundInputNoteRouteExtra(recordTime: recorderFile);
      SoundInputNoteRoute($extra: extra).push<void>(context);
    }
  }

  void uploadPendingHistory() {
    if (!mounted) return;

    final userId = context.read<UserBloc>().state.userModelOrThrowException.id;

    context.read<MainPendingHistoryBloc>().add(MainPendingHistoryUpload(userId: userId));
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
