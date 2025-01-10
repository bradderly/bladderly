enum Unit {
  ml,
  oz,
  ;

  num parse(num value) {
    return switch (this) {
      Unit.ml => value,
      Unit.oz => value / 29.5735,
    };
  }
}
