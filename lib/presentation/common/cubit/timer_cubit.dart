import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<DateTime> {
  TimerCubit() : super(DateTime.now()) {
    Timer.periodic(const Duration(milliseconds: 100), (_) => emit(DateTime.now()));
  }
}
