// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/get_history_usecase.dart';
import 'package:bladderly/presentation/feature/input/manual_input/manual_input_view.dart';
import 'package:flutter/material.dart';

class ManualInputBuilder extends StatefulWidget {
  const ManualInputBuilder({
    super.key,
    this.recordTime,
  });

  final DateTime? recordTime;

  @override
  State<ManualInputBuilder> createState() => _ManualInputBuilderState();
}

class _ManualInputBuilderState extends State<ManualInputBuilder> {
  late final history = switch (widget.recordTime) {
    final DateTime recordTime => getIt<GetHistoryUsecase>().call(recordTime: recordTime).fold((l) => null, (r) => r),
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    return ManualInputView(history: history);
  }
}
