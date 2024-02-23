part of 'recent_chat_cubit.dart';

@immutable
abstract class RecentChatState {}

class RecentChatInitial extends RecentChatState {}

class RecentChatLoading extends RecentChatState {}

class NoRecentChatFound extends RecentChatState {}

class RecentChatLoaded extends RecentChatState {
  final List<RecentChatModel> recentChatList;

  RecentChatLoaded(this.recentChatList);
}

class RecentChatError extends RecentChatState {
  final String error;

  RecentChatError(this.error);
}
