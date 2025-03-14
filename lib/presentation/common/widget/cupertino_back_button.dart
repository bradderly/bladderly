// Flutter imports:
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CupertinoBackButton extends StatelessWidget {
  const CupertinoBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => context.pop(),
      icon: const Icon(Icons.arrow_back_sharp),
    );
  }
}
