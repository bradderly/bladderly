extension DoubleExtension on double {
  int toRoundVolume() {
    return (this / 10).round() * 10;
  }
}
