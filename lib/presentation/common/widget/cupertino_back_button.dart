// Flutter imports:
import 'package:flutter/material.dart';

class CupertinoBackButton extends StatelessWidget {
  const CupertinoBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back_sharp),
    );
  }
}
