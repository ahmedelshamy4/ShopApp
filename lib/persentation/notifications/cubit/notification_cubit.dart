import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/notifications_model/notifications_model.dart';
import '../../../data/repository/notification_repository/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationsRepository)
      : super(NotificationInitial());

  final NotificationsRepository notificationsRepository;
  late NotificationsModel notificationsModel;
  Future<void> getNotificationsData() async {
    emit(NotificationsLoading());
    try {
      notificationsModel = await notificationsRepository.getNotificationsData();
      emit(NotificationsSuccess());
    } catch (error, s) {
      log('get notifications data error', error: error, stackTrace: s);
      emit(NotificationsError(error.toString()));
    }
  }
}
