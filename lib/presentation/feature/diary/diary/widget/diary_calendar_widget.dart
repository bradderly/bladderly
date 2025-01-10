import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomPageScrollPhysics extends ScrollPhysics {
  const CustomPageScrollPhysics({super.parent});

  @override
  CustomPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageScrollPhysics(parent: buildParent(ancestor));
  }

  double getPixels(ScrollMetrics position, double velocity) {
    // 현재 위치와 속도에 따라 목표 위치를 계산
    final page = position.pixels / position.viewportDimension;
    final targetPage = (velocity > 0)
        ? page.ceil() + velocity ~/ 100 // 스크롤 방향에 따른 페이지 증가
        : page.floor() + velocity ~/ 100;
    return targetPage * position.viewportDimension;
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if (velocity.abs() < tolerance.velocity) {
      return null; // 사용자가 스크롤을 거의 멈췄을 때
    }

    final pageSize = position.viewportDimension;
    final currentPage = position.pixels / pageSize;

    // 스크롤 방향에 따라 이동할 타겟 페이지 계산
    final targetPage = velocity > 0
        ? (currentPage + velocity.sign * math.max(1, velocity.abs() / 1000)).ceil()
        : (currentPage + velocity.sign * math.max(1, velocity.abs() / 1000)).floor();

    // 타겟 페이지 위치 계산 (항상 정렬된 위치로 스냅)
    final targetPixels = targetPage * pageSize;

    return ScrollSpringSimulation(
      spring,
      position.pixels,
      targetPixels,
      velocity,
      tolerance: tolerance,
    );
  }
}
