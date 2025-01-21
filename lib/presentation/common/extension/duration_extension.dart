extension DurationExtension on Duration {
  String formatHHMM() {
    final hours = '$inHours'.padLeft(2, '0');
    final minutes = '${inMinutes.remainder(60)}'.padLeft(2, '0');

    return '$hours:$minutes';
  }
}
