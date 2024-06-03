import 'package:apparence_kit/core/data/models/pageable.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';
import 'package:apparence_kit/modules/notifications/repositories/notifications_repository.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final notificationsPageStateProvider =
    AsyncNotifierProvider<NotificationsNotifier, Pageable<Notification>>(
  NotificationsNotifier.new,
);

class NotificationsNotifier extends AsyncNotifier<Pageable<Notification>> {
  var _locked = false;

  @override
  FutureOr<Pageable<Notification>> build() async {
    final notificationRepository = ref.read(notificationRepositoryProvider);
    final userState = ref.watch(userStateNotifierProvider);
    await Future.delayed(const Duration(milliseconds: 1500));
    return notificationRepository.get(userState.user.idOrThrow);
  }

  Future<void> readAll() async {
    if (!state.hasValue) {
      return;
    }
    try {
      final notificationRepository = ref.read(notificationRepositoryProvider);
      final userState = ref.watch(userStateNotifierProvider);
      final List<Notification> updatedNotifications = [];
      for (final notification in state.value!.data) {
        if (notification.seen) {
          continue;
        }
        updatedNotifications.add(
          await notificationRepository.read(
            userState.user.idOrThrow,
            notification,
          ),
        );
        await Future.delayed(const Duration(milliseconds: 100));
      }
      final List<Notification> oldNotifications = state
          .value! //
          .data
          .where((element) => element.seen)
          .toList();
      state = AsyncValue.data(
        state.value!.copyWith(
          data: [
            ...updatedNotifications,
            ...oldNotifications,
          ],
        ),
      );
    } catch (e) {
      Logger().e("error $e");
    }
  }

  Future<void> refresh() async {
    if (_locked) {
      return;
    }
    _locked = true;
    state = const AsyncValue.loading();
    final notificationRepository = ref.read(notificationRepositoryProvider);
    final userState = ref.watch(userStateNotifierProvider);
    await Future.delayed(const Duration(milliseconds: 1500));
    state = AsyncValue.data(
      await notificationRepository.get(userState.user.idOrThrow),
    );
    _locked = false;
  }

  Future<void> fetchNextPage() async {
    if (_locked) {
      return;
    }
    _locked = true;
    final notificationRepository = ref.read(notificationRepositoryProvider);
    final userState = ref.watch(userStateNotifierProvider);
    await Future.delayed(const Duration(milliseconds: 500));

    final pageNumber = state.value!.page + 1;
    final nextPage = await notificationRepository.get(
      userState.user.idOrThrow,
      page: pageNumber,
    );
    state = AsyncValue.data(
      state.value!.copyWith(
        page: pageNumber,
        data: [
          ...state.value!.data,
          ...nextPage.data,
        ],
      ),
    );
    _locked = false;
  }
}
