import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'paywall_state.dart';

class PaywallCubit extends Cubit<PaywallState> {
  PaywallCubit() : super(const PaywallState());

  void selectPlan(String planId) {
    emit(state.copyWith(selectedPlanId: planId));
  }
}
