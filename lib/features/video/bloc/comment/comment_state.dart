import 'package:helpert_app/features/video/model/comment_model.dart';

abstract class CommentState {}

class InitialState extends CommentState {}

class CommentLoading extends CommentState {}

class CommentSent extends CommentState {}

class CommentLikedDisliked extends CommentState {
  final String message;

  CommentLikedDisliked({required this.message});
}

class AllCommentsFetched extends CommentState {
  final List<CommentModel> comments;

  AllCommentsFetched({required this.comments});
}

class CommentError extends CommentState {
  final String error;

  CommentError(this.error);
}
