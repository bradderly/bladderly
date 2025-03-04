// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart' show IOClient;
import 'package:http/retry.dart' show RetryClient;

// Project imports:
import 'package:bladderly/data/api/client/converter/api_client_converter.dart';
import 'package:bladderly/data/api/client/interceptor/api_client_x_api_key_interceptor.dart';
import 'package:bladderly/data/api/client/interceptor/api_logging_interceptor.dart';
import 'package:bladderly/data/api/client/interceptor/api_response_exception_interceptor.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';

part 'api_client.chopper.dart';

@ChopperApi()
abstract class ApiClient extends ChopperService {
  static ApiClient create() {
    return _$ApiClient(
      ChopperClient(
        client: RetryClient(
          IOClient(),
          retries: 65535,
          delay: (retryCount) => const Duration(seconds: 3),
        ),
        baseUrl: Uri.parse('https://e9wd4zrpk5.execute-api.us-east-1.amazonaws.com/dev'),
        converter: ApiClientConverter(),
        interceptors: [
          ApiClientXApiKeyInterceptor(),
          ApiResponseExceptionInterceptor(),
          ApiLoggingInterceptor(
            logger: chopperLogger
              ..onRecord.listen((rec) {
                if (kDebugMode) {
                  print(rec.message);
                }
              }),
          ),
        ],
      ),
    );
  }

  @Post(path: '/change-pw')
  Future<Response<SimpleResponse>> changePassword({
    @Body() required ChagePwRequest request,
  });

  @Post(path: '/confirm-pw')
  Future<Response<SimpleResponse>> confirmPassword({
    @Body() required ConfirmPwRequest audioBytes,
  });

  @Post(path: '/delete-account')
  Future<Response<SimpleResponse>> deleteAccount({
    @Body() required PostEmailRequest request,
  });

  @Post(path: '/forgot-pw')
  Future<Response<SimpleResponse>> forgotPassword({
    @Body() required PostEmailRequest request,
  });

  @Post(path: '/log-in')
  Future<Response<LoginResponse>> logIn({
    @Body() required LoginRequest request,
  });

  @Post(path: '/log-out')
  Future<Response<SimpleResponse>> logOut({
    @Body() required Map<String, dynamic> request,
  });

  @Post(path: '/sign-up')
  Future<Response<SignUpResponse>> signUp({
    @Body() required SignUpRequest request,
  });

  @Get(path: '/check-promo')
  Future<Response<ResultResponse>> checkPromo({
    @Query('user_id') required String userId,
    @Query('code') required String code,
  });

  @Get(path: '/get-pay-info')
  Future<Response<GetPayResponse>> getPayInfo({
    @Query('user_id') required String userId,
    @Query('device') required String device,
  });

  @Post(path: '/post-pay-info')
  Future<Response<PostPayResponse>> checkPayment({
    @Body() required PaymentCheckRequest request,
  });

  @Post(
    path: '/audio-upload',
    headers: {'Content-Type': 'audio/m4a'},
  )
  Future<Response<SimpleResponse>> uploadAudio({
    @Header('file_name') required String fileName,
    @Body() required List<int> audioBytes,
  });

  @Post(path: '/contact-us')
  Future<Response<SimpleResponse>> contactUs({
    @Body() required ContactUsRequest request,
  });

  @Post(path: '/export-record')
  Future<Response<SimpleResponse>> exportRecord({
    @Body() required ExportReportRequest request,
  });

  @Get(path: '/get-all-records')
  Future<Response<GetAllResultResponse>> getAllRecords({
    @Query('user_id') required String userId,
  });

  @Get(path: '/get-result')
  Future<Response<ResultResponse>> getResult({
    @Query('user_id') required String userId,
    @Query('rec_date') required String recDate,
  });

  @Get(path: '/get-version')
  Future<Response<GetVersionResponse>> getVersion({
    @Query('device') required String device,
  });

  @Post(path: '/migrate-record')
  Future<Response<SimpleResponse>> migrateRecord({
    @Body() required DataMigrationRequest request,
  });

  @Post(path: '/report-purpose')
  Future<Response<SimpleResponse>> reportPurpose({
    @Body() required DataExportSurveyRequest request,
  });

  @Post(path: '/save-score')
  Future<Response<SimpleResponse>> saveScore({
    @Body() required SaveSurveyRequest request,
  });

  @Post(path: '/update-record')
  Future<Response<SimpleResponse>> updateRecord({
    @Body() required RecordUpdateRequest request,
  });
}
