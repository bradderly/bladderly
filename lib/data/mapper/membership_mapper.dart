import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/schema/membership_entity.dart';
import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/model/product.dart';

class MembershipMapper {
  const MembershipMapper._();

  static Membership fromMembershipEntity(MembershipEntity entity) {
    return Membership(
      subscription: switch (entity.subscription) {
        final MembershipSubscriptionEntity subscription => MembershipSubscription(
            product: Product.fromId(subscription.productId),
            startDate: subscription.startDate,
            endDate: subscription.endDate,
            autoRenewal: subscription.autoRenewal,
          ),
        _ => null,
      },
      remainCount: entity.remainCount,
    );
  }

  static Membership? fromGetPayResponse(GetPayResponse response) {
    final payInfo = response.payInfo;
    final subscription = payInfo == null ? null : _fromGetPayResponsePayInfo(payInfo);

    return Membership(
      subscription: subscription,
      remainCount: int.tryParse(payInfo?.remainCount ?? '0') ?? 0,
    );
  }

  static MembershipEntity toMembershipEntity({
    required int localUserId,
    required Membership membership,
  }) {
    return MembershipEntity()
      ..userId = localUserId
      ..remainCount = membership.remainCount
      ..subscription = switch (membership.subscription) {
        final MembershipSubscription subscription => MembershipSubscriptionEntity()
          ..productId = subscription.product.id
          ..startDate = subscription.startDate
          ..endDate = subscription.endDate
          ..autoRenewal = subscription.autoRenewal,
        _ => null,
      };
  }

  static MembershipSubscription? _fromGetPayResponsePayInfo(GetPayResponse$PayInfo payInfo) {
    try {
      return MembershipSubscription(
        product: Product.fromId(payInfo.productId!),
        startDate: DateTime.fromMillisecondsSinceEpoch(int.parse(payInfo.startDay!)),
        endDate: DateTime.fromMillisecondsSinceEpoch(int.parse(payInfo.endDay!)),
        autoRenewal: payInfo.autoRenewal == '1',
      );
    } catch (e) {
      return null;
    }
  }
}
