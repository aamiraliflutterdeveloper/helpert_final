abstract class MessageCountState {}

class InitialMessageCountState extends MessageCountState {}

class MessageCountLoaded extends MessageCountState {
  final int messageCount;

  MessageCountLoaded({required this.messageCount});
}
