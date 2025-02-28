import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/get_history_usecase.dart';
import 'package:bladderly/presentation/feature/input/manual_input/manual_input_view.dart';
import 'package:flutter/material.dart';

class ManualInputBuilder extends StatefulWidget {
  const ManualInputBuilder({
    super.key,
    this.historyId,
  });

  final int? historyId;

  @override
  State<ManualInputBuilder> createState() => _ManualInputBuilderState();
}

class _ManualInputBuilderState extends State<ManualInputBuilder> {
  late final history = switch (widget.historyId) {
    final int historyId => getIt<GetHistoryUsecase>().call(historyId: historyId).fold((l) => null, (r) => r),
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    return ManualInputView(history: history);
  }
}
