// ignore_for_file: invalid_annotation_target, constant_identifier_names

{{#firebase}}import 'package:apparence_kit/core/data/entities/json_converters.dart';{{/firebase}}
{{#firebase}}import 'package:cloud_firestore/cloud_firestore.dart';{{/firebase}}
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_entity.freezed.dart';
part 'subscription_entity.g.dart';

enum SubscriptionStatus {
  ACTIVE,
  PAUSED,
  EXPIRED,
  LIFETIME,
  CANCELLED,
}

{{#firebase}}
@freezed
sealed class SubscriptionEntity with _$SubscriptionEntity {
  const factory SubscriptionEntity({
    @JsonKey(includeIfNull: false, toJson: Converters.id) String? id,
    @JsonKey(name: 'offer_id') String? offerId,
    @JsonKey(name: 'product_id') required String skuId,
    @JsonKey(name: 'creation_date')
    @TimestampConverter()
    DateTime? creationDate,
    @JsonKey(name: 'last_activity')
    @TimestampConverter()
    DateTime? lastUpdateDate,
    @JsonKey(name: 'expiration_date')
    @TimestampConverter()
    DateTime? periodEndDate,
    @JsonKey(name: 'status') required SubscriptionStatus status,
  }) = SubscriptionEntityData;

  factory SubscriptionEntity.fromJson(String id, Map<String, Object?> json) =>
      _$SubscriptionEntityFromJson(json..['id'] = id);
}
{{/firebase}}{{#http_client}}
@freezed
sealed class SubscriptionEntity with _$SubscriptionEntity {
  const factory SubscriptionEntity({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(name: 'offer_id') required String offerId,
    @JsonKey(name: 'sku_id') required String skuId,
    @JsonKey(name: 'creation_date') DateTime? creationDate,
    @JsonKey(name: 'last_update_date') DateTime? lastUpdateDate,
    @JsonKey(name: 'period_end_date') DateTime? periodEndDate,
    @JsonKey(name: 'status') required SubscriptionStatus status,
  }) = SubscriptionEntityData;

  factory SubscriptionEntity.fromJson(Map<String, Object?> json) =>
      _$SubscriptionEntityFromJson(json);
}
{{/http_client}}{{#supabase}}
@freezed
sealed class SubscriptionEntity with _$SubscriptionEntity {
  const factory SubscriptionEntity({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'offer_id') required String offerId,
    @JsonKey(name: 'sku_id') required String skuId,
    @JsonKey(name: 'creation_date') DateTime? creationDate,
    @JsonKey(name: 'last_update_date') DateTime? lastUpdateDate,
    @JsonKey(name: 'period_end_date') DateTime? periodEndDate,
    @JsonKey(name: 'status') required SubscriptionStatus status,
  }) = SubscriptionEntityData;

  factory SubscriptionEntity.fromJson(Map<String, Object?> json) =>
      _$SubscriptionEntityFromJson(json);
}
{{/supabase}}
