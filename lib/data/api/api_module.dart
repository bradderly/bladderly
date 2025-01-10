// Package imports:
import 'package:bradderly/data/api/client/api_client.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ApiModule {
  @lazySingleton
  ApiClient get apiClient => ApiClient.create();
}
