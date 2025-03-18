enum ScoreType {
  IPSS,
  OABSS,
  ;

  int get maxTotalScore {
    return switch (this) {
      ScoreType.IPSS => 35,
      ScoreType.OABSS => 15,
    };
  }
}
