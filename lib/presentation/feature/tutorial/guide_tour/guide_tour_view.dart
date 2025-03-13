import 'package:bladderly/presentation/common/cubit/main_tab_cubit.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/feature/tutorial/guide_tour/widget/guide_tour_export_widget.dart';
import 'package:bladderly/presentation/feature/tutorial/guide_tour/widget/guide_tour_set_up_widget.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuideTourView extends StatefulWidget {
  const GuideTourView({super.key});

  @override
  State<GuideTourView> createState() => _GuideTourViewState();
}

class _GuideTourViewState extends State<GuideTourView> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width - 64,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              decoration: BoxDecoration(
                color: context.colorTheme.neutral.shade0,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                height: 360,
                child: PageView(
                  onPageChanged: (index) {
                    setState(() => step = index);
                    context.read<MainTabCubit>().showIndex(step);
                  },
                  children: const [
                    GuideTourSetUpWidget(),
                    GuideTourExportWidget(),
                  ],
                ),
              ),
            ),
          ),
          if (step == 0)
            Positioned.fill(
              top: null,
              bottom: 78,
              child: Row(
                children: [Assets.icon.icGuideTourStepOne, Assets.icon.icGuideTourStepTwo]
                    .map((element) => Expanded(child: Center(child: element.svg())))
                    .toList(),
              ),
            ),
          if (step == 1)
            Positioned(
              top: 20,
              right: 46,
              child: Assets.icon.icGuideTourStepThree.svg(),
            ),
        ],
      ),
    );
  }
}
