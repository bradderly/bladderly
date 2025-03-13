import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/schema/membership_entity.dart';
import 'package:bladderly/domain/model/membership.dart';

class MembershipMapper {
  const MembershipMapper._();

  static Membership fromMembershipEntity(MembershipEntity entity) {
    return Membership(
      productId: entity.productId,
      startDate: entity.startDate,
      endDate: entity.endDate,
      autoRenewal: entity.autoRenewal,
    );
  }

  static Membership? fromGetPayResponse(GetPayResponse response) {
    return switch (response.payInfo) {
      final GetPayResponsePayInfo payInfo => Membership(
          productId: payInfo.productId!,
          startDate: DateTime.fromMillisecondsSinceEpoch(int.parse(payInfo.startDay!)),
          endDate: DateTime.fromMillisecondsSinceEpoch(int.parse(payInfo.endDay!)),
          autoRenewal: payInfo.autoRenewal == '1',
        ),
      _ => null,
    };
  }

  static MembershipEntity toMembershipEntity({
    required int localUserId,
    required Membership membership,
  }) {
    return MembershipEntity()
      ..userId = localUserId
      ..productId = membership.productId
      ..startDate = membership.startDate
      ..endDate = membership.endDate
      ..autoRenewal = membership.autoRenewal;
  }
}
