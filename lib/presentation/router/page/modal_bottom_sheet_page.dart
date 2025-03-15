import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalBottomSheetPage<T> extends Page<T> {
  const ModalBottomSheetPage({
    required super.key,
    required this.builder,
    this.expanded = true,
    this.closeProgressThreshold,
    this.containerBuilder,
    this.scrollController,
    this.secondAnimationController,
    this.modalBarrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
    this.bounce = false,
    this.animationCurve,
    this.duration = const Duration(milliseconds: 400),
  });

  final double? closeProgressThreshold;
  final WidgetWithChildBuilder? containerBuilder;
  final WidgetBuilder builder;
  final bool expanded;
  final bool bounce;
  final Color? modalBarrierColor;
  final bool isDismissible;
  final bool enableDrag;
  final ScrollController? scrollController;
  final Duration duration;
  final AnimationController? secondAnimationController;
  final Curve? animationCurve;

  @override
  Route<T> createRoute(BuildContext context) {
    return ModalSheetRoute<T>(
      settings: this,
      closeProgressThreshold: closeProgressThreshold,
      containerBuilder: containerBuilder,
      builder: (context) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.05 - MediaQuery.paddingOf(context).top),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: switch (ModalRoute.of(context)!.settings) {
                final ModalBottomSheetPage page => page.builder(context),
                _ => builder(context),
              },
            ),
          ),
        ),
      ),
      expanded: expanded,
      bounce: bounce,
      modalBarrierColor: modalBarrierColor,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      scrollController: scrollController,
      duration: duration,
      secondAnimationController: secondAnimationController,
      animationCurve: animationCurve,
    );
  }
}
