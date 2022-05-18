part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationsLoading extends NotificationState {}

class NotificationsSuccess extends NotificationState {}

class NotificationsError extends NotificationState {
  final String message;

  NotificationsError(this.message);
}
