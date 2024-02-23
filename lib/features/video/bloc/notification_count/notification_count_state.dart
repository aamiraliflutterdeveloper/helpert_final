abstract class NotificationCountState {}

class InitialNotificationCountState extends NotificationCountState {}

class NotificationCountLoaded extends NotificationCountState {
  final int notificationCount;

  NotificationCountLoaded({required this.notificationCount});
}
