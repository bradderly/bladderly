import 'package:equatable/equatable.dart';

class PromoResult extends Equatable {
  const PromoResult({
    required String result,
    required this.popup,
  }) : _result = result;

  final String _result;
  final String popup;

  bool get needCheckMembership => _result == 'exist';

  @override
  List<Object?> get props => [
        _result,
        popup,
      ];
}
