enum Unit {
  ml,
  oz,
  ;

  static double get convertRate => 29.5735;

  int parseFromMl(int value) {
    return switch (this) {
      Unit.ml => value,
      Unit.oz => (value / convertRate).round(),
    };
  }

  int parseToMl(int value) {
    return switch (this) {
      Unit.ml => value,
      Unit.oz => (value * convertRate / 10).round() * 10,
    };
  }
}
