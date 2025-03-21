import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryDateCubit extends Cubit<DateTime> {
  DiaryDateCubit() : super(DateUtils.dateOnly(DateTime.now()));

  void changeDate(DateTime date) {
    emit(DateUtils.dateOnly(date));
  }
}
