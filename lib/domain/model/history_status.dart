enum HistoryStatus {
  /// 업로드 대기 상태
  pendingUpload,

  /// 음성 파일 분석 중인 상태
  processing,

  /// 완료 상태
  done,

  /// 삭제 상태
  deleted,
}
