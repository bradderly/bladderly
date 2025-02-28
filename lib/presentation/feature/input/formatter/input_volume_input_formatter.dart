import 'package:bladderly/domain/model/unit.dart';
import 'package:flutter/services.dart';

class InputVolumeFormatter extends TextInputFormatter {
  InputVolumeFormatter({required this.unit});

  final Unit unit;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final mlValue = switch (unit) {
      Unit.ml => int.tryParse(newValue.text) ?? 0,
      Unit.oz => unit.parseToMl(int.tryParse(newValue.text) ?? 0),
    };

    return mlValue > 1000 ? oldValue : newValue;
  }
}
