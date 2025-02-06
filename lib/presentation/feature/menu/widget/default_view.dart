import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultView extends StatelessWidget {
  const DefaultView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child:  const Scaffold(
        
      ),
    );
  
  }
}