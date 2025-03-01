import 'dart:async';

import 'package:bladderly/data/api/client/exception/api_response_body_empty_exception.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:chopper/chopper.dart';

class ApiResponseExceptionInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) {
    if (response.body == null && response is! Response<LoginResponse>) {
      throw const ApiResponseBodyEmptyException();
    }

    return response;
  }
}
