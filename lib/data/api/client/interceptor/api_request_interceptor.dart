// Package imports:
import 'package:chopper/chopper.dart';

class ApiRequestInterceptor implements RequestInterceptor {
  const ApiRequestInterceptor();
  @override
  Future<Request> onRequest(Request request) {
    return Future.value(
      request.copyWith(
        headers: {
          ...request.headers,
          'x-api-key': '3rXDcDwBhc18isTzhlsZd8JnmYU4Plkp3pGf5hiN',
          if (!request.uri.path.contains('audio-upload')) 'Content-Type': 'application/json',
        },
      ),
    );
  }
}
