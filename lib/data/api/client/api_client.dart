// Package imports:
import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart' show IOClient;
import 'package:http/retry.dart' show RetryClient;

part 'api_client.chopper.dart';

@ChopperApi()
abstract class ApiClient extends ChopperService {
  static ApiClient create() {
    // final baseUrl = Uri.parse(dotenv.get('BASE_URL'));

    return _$ApiClient(
      ChopperClient(
        client: RetryClient(
          IOClient(),
          retries: 65535,
          delay: (retryCount) => const Duration(seconds: 3),
        ),
        baseUrl: Uri.parse('https://e9wd4zrpk5.execute-api.us-east-1.amazonaws.com/dev'),
        // converter: SwaggerConverter(),
        // services: [
        //   _$ApiClient(),
        // ],
        // interceptors: [
        //   LoggingInterceptor(logger: Logger()),
        //   const ApiResponseInterceptor(),
        // ],
      ),
    );
  }

  @Post(
    path: '/audio-upload',
    headers: {
      'x-api-key': '3rXDcDwBhc18isTzhlsZd8JnmYU4Plkp3pGf5hiN',
      'Content-Type': 'audio/m4a',
    },
    optionalBody: false,
  )
  Future<Response> uploadAudioFile({
    @Body() required List<int> audioBytes,
    @Header('file_name') required String fileName,
  });
}
