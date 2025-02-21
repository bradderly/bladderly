import 'package:bradderly/core/recorder/recorder_module.dart';
import 'package:bradderly/core/recorder/src/recorder_file.dart';
import 'package:bradderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bradderly/presentation/feature/diary/diary/diary_builder.dart';
import 'package:bradderly/presentation/feature/diary/diary/model/diary_tab_scroll_section_model.dart';
import 'package:bradderly/presentation/feature/main/cubit/main_tab_cubit.dart';
import 'package:bradderly/presentation/feature/main/home/home_builder.dart';
import 'package:bradderly/presentation/feature/main/widget/main_bottom_navigation_bar.dart';
import 'package:bradderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatefulWidget {
  const MainView({
    super.key,
    required this.recorder,
  });

  final Recorder recorder;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final pageController = PageController();

  @override
  void initState() {
    super.initState();
    GoRouter.of(context).routeInformationProvider.addListener(routeInfomationProviderListener);

    WidgetsBinding.instance.addPostFrameCallback((_) => checkPendingUploadFile());
  }

  @override
  void dispose() {
    GoRouter.of(context).routeInformationProvider.removeListener(routeInfomationProviderListener);
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

    if (recorderFile case final RecorderFile recorderFile when widget.recorder.exist(recorderFile)) {
      final extra = SoundInputNoteRouteExtra(file: recorderFile);

      SoundInputNoteRoute($extra: extra).push<void>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainTabCubit, MainTabState>(
      listenWhen: (prev, curr) => prev.index != curr.index,
      listener: (context, state) => pageController.jumpToPage(state.index),
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
