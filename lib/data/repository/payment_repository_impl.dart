import 'package:bladderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/domain/model/promo_result.dart';
import 'package:bladderly/domain/repository/payment_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl({
    required ApiClient apiClient,
    required DeviceInfoModel deviceInfoModel,
  })  : _apiClient = apiClient,
        _deviceInfoModel = deviceInfoModel;

  final ApiClient _apiClient;
  final DeviceInfoModel _deviceInfoModel;

  @override
  Future<PostPayResponse> verifyPayment({
    required String userId,
    required String productId,
    required String purchaseToken,
    required String receipt,
  }) async {
    final result = await _apiClient.checkPayment(
      request: PaymentCheckRequest(
        userId: userId,
        device: _deviceInfoModel.os,
        productId: productId,
        purchaseToken: purchaseToken,
        receipt: receipt,
      ),
    );

    return result.body!;
  }

  @override
  Future<void> purchaseWithoutIap({
    required String userId,
    required String productId,
  }) {
    return _apiClient
        .checkPayment(request: PaymentCheckRequest(userId: userId, device: _deviceInfoModel.os, productId: productId))
        .then((value) => value.body!);
  }

  @override
  Future<PromoResult> checkPromo({
    required String userId,
    required String code,
  }) async {
    final response = await _apiClient.checkPromo(userId: userId, code: code).then((response) => response.body!);

    return PromoResult(result: response.result!, popup: response.popup!);
  }
}
