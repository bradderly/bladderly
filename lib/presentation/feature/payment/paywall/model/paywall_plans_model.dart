import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/presentation/feature/payment/paywall/model/paywall_plan_model.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class PaywallPlansModel extends Equatable {
  PaywallPlansModel({
    required List<PaywallPlanModel> list,
  }) : _list = List.unmodifiable(list);

  PaywallPlansModel.fromDomain(List<Plan> plans) : _list = plans.map(PaywallPlanModel.fromDomain).toList();

  final List<PaywallPlanModel> _list;

  PaywallPlanModel? get stater => _list.firstWhereOrNull((element) => element.id == 'starter');

  int get length => _list.length;

  PaywallPlanModel operator [](int index) => _list[index];

  @override
  List<Object?> get props => [
        _list,
      ];
}
