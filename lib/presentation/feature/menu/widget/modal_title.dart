
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

Widget ModalTitle (BuildContext context, String title) {
  return Container(
    width: double.infinity,
    child: Stack(
                        alignment: Alignment.center,
                        children: [
                           Text(
                          title,
                          style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),  
                          ),
                          Positioned(
                          right: 0,
                            child: IconButton(
                            icon:  Icon(Icons.close,color: context.colorTheme.neutral.shade10,),
                            onPressed: () => Navigator.pop(context),
                            ),
                          ),
                         
                        ],
                      ),
  );
}