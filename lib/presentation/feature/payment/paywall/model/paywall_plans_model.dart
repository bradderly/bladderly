import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:bladderly/presentation/feature/payment/paywall/model/paywall_plan_model.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class PaywallPlansModel extends Equatable {
  PaywallPlansModel({
    required List<PaywallPlanModel> list,
  }) : _list = List.unmodifiable(list);

  factory PaywallPlansModel.fromDomain(List<Plan> plans) =>
      PaywallPlansModel(list: plans.map(PaywallPlanModel.fromDomain).toList());

  final List<PaywallPlanModel> _list;

  int get length => _list.length;

  PaywallPlanModel operator [](int index) => _list[index];

  PaywallPlansModel get withoutThreeDaysPass =>
      PaywallPlansModel(list: _list.where((element) => element.product != Product.threeDaysPass).toList());

  PaywallPlanModel? get threeDaysPass => _list.firstWhereOrNull((element) => element.product == Product.threeDaysPass);

  PaywallPlanModel? firstWhereByProduct(Product product) =>
      _list.firstWhereOrNull((element) => element.product == product);

  @override
  List<Object?> get props => [
        _list,
      ];
}
