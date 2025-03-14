// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/feature/export/export_view.dart';
import 'package:flutter/material.dart';

class ExportBuilder extends StatelessWidget {
  const ExportBuilder({
    super.key,
    required this.navigator,
  });

  final Widget navigator;

  @override
  Widget build(BuildContext context) {
    return ExportView(navigator: navigator);
  }
}
