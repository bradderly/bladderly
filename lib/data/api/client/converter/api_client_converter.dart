// Dart imports:
import 'dart:async';
import 'dart:convert';

// Project imports:
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
// Package imports:
import 'package:chopper/chopper.dart' as chopper;

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class _CustomJsonDecoder {
  _CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (chopper.isTypeOf<T, Map>()) {
      return entity;
    }

    if (chopper.isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw Exception(
        "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?",
      );
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) => values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class ApiClientConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (response.isSuccessful) {
      final jsonParser = _jsonDecoder.factories[Item];
      final json = Map<String, dynamic>.from(jsonDecode(response.bodyString) as Map);

      final parsedBody = jsonParser?.call(json);

      return response.copyWith<ResultType>(body: parsedBody as ResultType);
    }

    return super.convertResponse<ResultType, Item>(response);
  }
}

final _jsonDecoder = _CustomJsonDecoder({
  /** RESPONSE */
  SimpleResponse: SimpleResponse.fromJsonFactory,
  ResultResponse: ResultResponse.fromJsonFactory,
  LoginResponse: LoginResponse.fromJsonFactory,
  GetVersionResponse: GetVersionResponse.fromJsonFactory,
  GetAllResultResponse: GetAllResultResponse.fromJsonFactory,
  GetPayResponse: GetPayResponse.fromJsonFactory,
  PostPayResponse: PostPayResponse.fromJsonFactory,
  SignUpResponse: SignUpResponse.fromJsonFactory,
});
