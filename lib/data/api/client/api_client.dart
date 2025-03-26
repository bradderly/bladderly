// Flutter imports:

// Project imports:
import 'package:bladderly/data/api/client/converter/api_client_converter.dart';
import 'package:bladderly/data/api/client/interceptor/api_logging_interceptor.dart';
import 'package:bladderly/data/api/client/interceptor/api_request_interceptor.dart';
import 'package:bladderly/data/api/client/interceptor/api_response_exception_interceptor.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
// Package imports:
import 'package:chopper/chopper.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart' show IOClient;
import 'package:http/retry.dart' show RetryClient;

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
          const ApiRequestInterceptor(),
          const ApiResponseExceptionInterceptor(),
          ApiLoggingInterceptor(
            logger: chopperLogger
              ..onRecord.listen((rec) {
                if (kDebugMode) print(rec.message);
              }),
          ),
        ],
      ),
    );
  }

  @POST(path: '/change-pw')
  Future<Response<SimpleResponse>> changePassword({
    @Body() required ChagePwRequest request,
  });

  @POST(path: '/confirm-pw')
  Future<Response<SimpleResponse>> confirmPassword({
    @Body() required ConfirmPwRequest request,
  });

  @POST(path: '/delete-account')
  Future<Response<SimpleResponse>> deleteAccount({
    @Body() required PostEmailRequest request,
  });

  @POST(path: '/forgot-pw')
  Future<Response<SimpleResponse>> forgotPassword({
    @Body() required PostEmailRequest request,
  });

  @POST(path: '/log-in')
  Future<Response<LoginResponse>> logIn({
    @Body() required LoginRequest request,
  });

  @POST(path: '/log-out')
  Future<Response<SimpleResponse>> logOut({
    @Body() required Map<String, dynamic> request,
  });

  @POST(path: '/sign-up')
  Future<Response<SignUpResponse>> signUp({
    @Body() required SignUpRequest request,
  });

  @GET(path: '/check-promo')
  Future<Response<PromoResponse>> checkPromo({
    @Query('user_id') required String userId,
    @Query('code') required String code,
    @Query('device') required String os,
  });

  @GET(path: '/get-pay-info')
  Future<Response<GetPayResponse>> getPayInfo({
    @Query('user_id') required String userId,
    @Query('device') required String device,
  });

  @POST(path: '/post-pay-info')
  Future<Response<PostPayResponse>> checkPayment({
    @Body() required PaymentCheckRequest request,
  });

  @POST(
    path: '/audio-upload',
    headers: {'Content-Type': 'audio/m4a'},
  )
  Future<Response<SimpleResponse>> uploadAudio({
    @Header('file_name') required String fileName,
    @Body() required List<int> audioBytes,
  });

  @POST(path: '/contact-us')
  Future<Response<SimpleResponse>> contactUs({
    @Body() required ContactUsRequest request,
  });

  @POST(path: '/export-record')
  Future<Response<SimpleResponse>> exportRecord({
    @Body() required ExportReportRequest request,
  });

  @GET(path: '/get-all-records')
  Future<Response<GetAllResultResponse>> getAllRecords({
    @Query('user_id') required String userId,
  });

  @GET(path: '/get-result')
  Future<Response<ResultResponse>> getResult({
    @Query('user_id') required String userId,
    @Query('rec_date') required String recDate,
  });

  @GET(path: '/get-version')
  Future<Response<GetVersionResponse>> getVersion({
    @Query('device') required String device,
  });

  @POST(path: '/migrate-record')
  Future<Response<SimpleResponse>> migrateRecord({
    @Body() required DataMigrationRequest request,
  });

  @POST(path: '/report-purpose')
  Future<Response<SimpleResponse>> reportPurpose({
    @Body() required DataExportSurveyRequest request,
  });

  @POST(path: '/save-score')
  Future<Response<SimpleResponse>> saveScore({
    @Body() required SaveSurveyRequest request,
  });

  @POST(path: '/update-record')
  Future<Response<SimpleResponse>> updateRecord({
    @Body() required RecordUpdateRequest request,
  });

  @POST(path: '/update-user-info')
  Future<Response<SimpleResponse>> updateUserName({
    @Body() required UpdateUserInfoRequest request,
  });

  @GET(path: '/support-models')
  Future<Response<GetSupportModelsResponse>> getSupportModels({
    @Query('device') required String os,
  });
}
