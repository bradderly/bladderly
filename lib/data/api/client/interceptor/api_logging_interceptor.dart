// Dart imports:
import 'dart:async';

// Package imports:
import 'package:chopper/chopper.dart';

class ApiLoggingInterceptor extends HttpLoggingInterceptor {
  ApiLoggingInterceptor({
    super.level,
    super.logger,
  });

  @override
  FutureOr<Request> onRequest(Request request) {
    // 파일 업로드 요청 시 로그 출력 제외
    if (request.uri.path.contains('audio-upload')) {
      return request;
    }

    return super.onRequest(request);
  }
}
