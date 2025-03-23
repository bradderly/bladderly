import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<DateTime> with WidgetsBindingObserver {
  TimerCubit() : super(DateTime.now()) {
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
  }

  Timer? timer;

  void _startTimer() {
    _stopTimer();
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
  }

  void _stopTimer() {
    timer?.cancel();
    timer = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startTimer();
    } else {
      _stopTimer();
    }
  }

  void _onTick(Timer _) => emit(DateTime.now());

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
