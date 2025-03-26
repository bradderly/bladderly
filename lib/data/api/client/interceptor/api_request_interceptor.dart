// Package imports:
import 'dart:async';

import 'package:chopper/chopper.dart';

class ApiRequestInterceptor implements Interceptor {
  const ApiRequestInterceptor();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    return chain.proceed(
      chain.request.copyWith(
        headers: {
          ...chain.request.headers,
          'x-api-key': '3rXDcDwBhc18isTzhlsZd8JnmYU4Plkp3pGf5hiN',
          if (!chain.request.uri.path.contains('audio-upload')) 'Content-Type': 'application/json',
        },
      ),
    );
  }
}
