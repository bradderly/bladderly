// Package imports:
import 'package:chopper/chopper.dart';

class ApiClientXApiKeyInterceptor implements RequestInterceptor {
  @override
  Future<Request> onRequest(Request request) async {
    return request.copyWith(
      headers: {
        ...request.headers,
        'x-api-key': '3rXDcDwBhc18isTzhlsZd8JnmYU4Plkp3pGf5hiN',
        if (!request.uri.path.contains('audio-upload')) 'Content-Type': 'application/json',
      },
    );
  }
}
