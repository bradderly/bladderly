// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/data/api/client/api_client.dart';

@module
abstract class ApiModule {
  @lazySingleton
  ApiClient get apiClient => ApiClient.create();
}
