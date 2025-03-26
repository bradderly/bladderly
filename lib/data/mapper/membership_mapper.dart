import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/local/schema/membership_entity.dart';
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
      exportRemainCount: entity.exportRemainCount,
    );
  }

  static Membership? fromGetPayResponse(GetPayResponse response) {
    final payInfo = response.payInfo;
    final subscription = payInfo == null ? null : _fromGetPayResponsePayInfo(payInfo);

    final consumableInfo = response.consumableInfo;

    return Membership(
      subscription: subscription,
      remainCount: switch (payInfo?.remainCount) {
        final String remainCount => int.tryParse(remainCount) ?? 0,
        _ => 0,
      },
      exportRemainCount: switch (consumableInfo?.exportRemainCount) {
        final String exportRemainCount => int.tryParse(exportRemainCount) ?? 0,
        _ => 0,
      },
    );
  }

  static MembershipEntity toMembershipEntity({
    required int localUserId,
    required Membership membership,
  }) {
    return MembershipEntity()
      ..userId = localUserId
      ..remainCount = membership.remainCount
      ..exportRemainCount = membership.exportRemainCount
      ..productId = membership.subscription?.product.id
      ..startDate = membership.subscription?.startDate
      ..endDate = membership.subscription?.endDate
      ..autoRenewal = membership.subscription?.autoRenewal;
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
