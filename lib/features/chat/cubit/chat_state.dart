part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class NoChatFound extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Chat> chatList;

  ChatLoaded(this.chatList);
}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);
}
