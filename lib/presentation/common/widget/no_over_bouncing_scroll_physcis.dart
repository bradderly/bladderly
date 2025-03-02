// Flutter imports:
import 'package:flutter/material.dart';

/// IOS의 관성 스크롤에 오버스크롤을 제거한 스크롤 피직스입니다.
class NoOverBouncingScrollPhysics extends BouncingScrollPhysics {
  const NoOverBouncingScrollPhysics({
    super.decelerationRate = ScrollDecelerationRate.normal,
    super.parent,
  });

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels && position.pixels <= position.minScrollExtent) {
      // Underscroll.
      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels && position.pixels < value) {
      // Overscroll.
      return value - position.pixels;
    }
    if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) {
      // Hit top edge.
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) {
      // Hit bottom edge.
      return value - position.maxScrollExtent;
    }
    return 0;
  }
}
