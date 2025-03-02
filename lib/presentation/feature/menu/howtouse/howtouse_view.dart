// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:bladderly/presentation/feature/menu/howtouse/howtouse_woman.dart';

class HowtouseView extends StatelessWidget {
  const HowtouseView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: HowtouseWoman(), // HowtouseMan(),
    );
  }
}
