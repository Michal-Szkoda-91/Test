import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/modules/subscription/domain/subscription.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState({
    required User user,
    required Subscription subscription,
  }) = UserStateData;
}
