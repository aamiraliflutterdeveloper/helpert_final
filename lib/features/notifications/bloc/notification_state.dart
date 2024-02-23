import '../model/notification_model.dart';

abstract class NotificationState {}

class InitialNotificationState extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationLoaded({required this.notifications});
}

class NotificationError extends NotificationState {
  final String error;

  NotificationError(this.error);
}
