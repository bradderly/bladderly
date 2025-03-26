// Dart imports:
import 'dart:async';
import 'dart:convert';

// Project imports:
import 'package:bladderly/data/api/client/exception/api_response_body_empty_exception.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/domain/exception/code_mismatch_exception.dart';
import 'package:bladderly/domain/exception/invalid_user_exception.dart';
import 'package:bladderly/domain/exception/reset_social_user_password_exception.dart';
// Package imports:
import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

class ApiResponseExceptionInterceptor implements Interceptor {
  const ApiResponseExceptionInterceptor();

  void _logResponse(Response response) {
    final base = response.base;

    var reasonPhrase = response.statusCode.toString();
    var bodyMessage = '';
    if (base is http.Response) {
      if (base.reasonPhrase != null) {
        reasonPhrase += ' ${base.reasonPhrase != reasonPhrase ? base.reasonPhrase : ''}';
      }

      if (base.body.isNotEmpty) {
        bodyMessage = base.body;
      }
    }

    // Always start on a new line
    chopperLogger
      ..info(ChopperLogRecord('', response: response))
      ..info(
        ChopperLogRecord(
          '<-- $reasonPhrase ${base.request?.method} ${base.request?.url}',
          response: response,
        ),
      );

    base.headers.forEach(
      (k, v) => chopperLogger.info(ChopperLogRecord('$k: $v', response: response)),
    );

    if (base.contentLength != null && base.headers['content-length'] == null) {
      chopperLogger.info(ChopperLogRecord('content-length: ${base.contentLength}', response: response));
    }

    if (bodyMessage.isNotEmpty) {
      chopperLogger
        ..info(ChopperLogRecord('', response: response))
        ..info(ChopperLogRecord(bodyMessage, response: response));
    }

    chopperLogger.info(ChopperLogRecord('<-- END HTTP', response: response));
  }

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final response = await chain.proceed(chain.request);

    if (response.base.request?.url.path.contains('confirm-pw') == true &&
        response.bodyString.contains('${const CodeMismatchException().runtimeType}')) {
      throw const CodeMismatchException();
    }

    if (response.base.request?.url.path.contains('forgot-pw') == true && response.statusCode != 200) {
      final message = SimpleResponse.fromJson(jsonDecode(response.bodyString) as Map<String, dynamic>).message;
      throw ResetSocialUserPasswordException.fromMessage(message!);
    }

    if (response.base.request?.url.path.contains('change-pw') == true && response.statusCode == 401) {
      throw const InvalidUserException.fromChangePw();
    }

    if (response.body == null && response is! Response<LoginResponse>) {
      _logResponse(response);
      throw const ApiResponseBodyEmptyException();
    }

    return response;
  }
}
