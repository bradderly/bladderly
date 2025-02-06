import 'package:bradderly/presentation/feature/menu/howtouse/howtouse_man.dart';
import 'package:bradderly/presentation/feature/menu/howtouse/howtouse_woman.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HowtouseView extends StatelessWidget {
  const HowtouseView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: HowtouseWoman() ,// HowtouseMan(),
    );
  
  }
}