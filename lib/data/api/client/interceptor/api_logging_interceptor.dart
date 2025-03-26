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
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    // 파일 업로드 요청 시 로그 출력 제외
    if (chain.request.uri.path.contains('audio-upload')) {
      return chain.proceed(chain.request);
    }

    return super.intercept(chain);
  }
}
