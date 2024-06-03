// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionEntityDataImpl _$$SubscriptionEntityDataImplFromJson(Map json) =>
    _$SubscriptionEntityDataImpl(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      offerId: json['offer_id'] as String,
      skuId: json['sku_id'] as String,
      creationDate: json['creation_date'] == null
          ? null
          : DateTime.parse(json['creation_date'] as String),
      lastUpdateDate: json['last_update_date'] == null
          ? null
          : DateTime.parse(json['last_update_date'] as String),
      periodEndDate: json['period_end_date'] == null
          ? null
          : DateTime.parse(json['period_end_date'] as String),
      status: $enumDecode(_$SubscriptionStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$SubscriptionEntityDataImplToJson(
    _$SubscriptionEntityDataImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['user_id'] = instance.userId;
  val['offer_id'] = instance.offerId;
  val['sku_id'] = instance.skuId;
  val['creation_date'] = instance.creationDate?.toIso8601String();
  val['last_update_date'] = instance.lastUpdateDate?.toIso8601String();
  val['period_end_date'] = instance.periodEndDate?.toIso8601String();
  val['status'] = _$SubscriptionStatusEnumMap[instance.status]!;
  return val;
}

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.ACTIVE: 'ACTIVE',
  SubscriptionStatus.PAUSED: 'PAUSED',
  SubscriptionStatus.EXPIRED: 'EXPIRED',
  SubscriptionStatus.LIFETIME: 'LIFETIME',
  SubscriptionStatus.CANCELLED: 'CANCELLED',
};
