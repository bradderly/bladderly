enum HistoryStatus {
  /// 업로드 대기 상태
  pending,

  /// 음성 파일 분석 중인 상태
  processing,

  /// 음성 파일 분석 실패 새로고침 필요한 상태
  failed,

  /// 완료 상태
  done,
}
