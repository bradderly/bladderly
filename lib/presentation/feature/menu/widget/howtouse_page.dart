
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class HowtousePage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  HowtousePage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 330,width: 300.5,),
        SizedBox(height: 20),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 46),
             child: Text(
              title,
              textAlign: TextAlign.center,
              style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
                       ),
           ),
        if (description.isNotEmpty) ...[
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade7),
            ),
          ),
        ],
      ],
    );
  }
}