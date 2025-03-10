import 'package:bladderly/domain/exception/domain_exception.dart';

class GetHistoryResultFailureException extends DomainException {
  const GetHistoryResultFailureException._({
    required super.message,
    required this.recordTime,
  });

  factory GetHistoryResultFailureException.errorType({
    required String errorType,
    required DateTime recordTime,
  }) {
    return GetHistoryResultFailureException._(
      message: switch (errorType) {
        'ERR_ANALYZING' => 'Err_analyzing',
        'ERR_LENGTH' => 'Err_length',
        'ERR_HIGHFREQ_CUT' => 'Err_highfreq_cut',
        'ERR_NO_VOID' => 'Err_no_void',
        'ERR_NOISY_ENV' => 'Err_noisy_env',
        'ERR_VV' => 'Err_VV',
        'ERR_OV' => 'Err_VV',
        'ERR_Q_MAX' => 'Err_VV',
        'ERR_FT' => 'Err_VV',
        'ERR_Q_AVG' => 'Err_VV',
        _ => 'An unknown error occurred',
      },
      recordTime: recordTime,
    );
  }

  final DateTime recordTime;
}
