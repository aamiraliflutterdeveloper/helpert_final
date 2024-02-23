import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/video/bloc/comment/comment_state.dart';
import 'package:helpert_app/features/video/model/comment_model.dart';
import 'package:helpert_app/features/video/repo/video_repo.dart';

class CommentBloc extends Cubit<CommentState> {
  CommentBloc() : super(InitialState());

  fetchAllComments(int? videoId) async {
    emit(CommentLoading());
    //try {
    var data = FormData.fromMap({
      'video_bots_id': videoId,
      // 'video_bot_question_id': questionId,
    });
    List<CommentModel> commentList =
        await VideoRepo.instance.getVideoCommentsApi(data);
    emit(AllCommentsFetched(comments: commentList.reversed.toList()));
    // } catch (e) {
    //   emit(CommentError(e.toString()));
    // }
  }

  Future<void> videoCreateComment(String comment, int? topicId) async {
    try {
      var data = FormData.fromMap({
        'video_bots_id': topicId,
        'comment': comment,
      });
      CommentModel result =
          await VideoRepo.instance.videoCreateCommentApi(data);
      final currentState = state;
      if (currentState is AllCommentsFetched) {
        List<CommentModel> commentList = currentState.comments;
        commentList.add(result);
        emit(CommentSent());
        emit(AllCommentsFetched(comments: commentList.reversed.toList()));
      }
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  Future<void> videoReplyComment(
      String comment, int? topicId, int commentId, int index) async {
    try {
      var data = FormData.fromMap({
        'video_bots_id': topicId,
        // 'video_bot_question_id': videoId,
        'comment': comment,
        'comment_id': commentId,
      });
      CommentModel result = await VideoRepo.instance.videoReplyCommentApi(data);
      final currentState = state;
      if (currentState is AllCommentsFetched) {
        List<CommentModel> commentList = currentState.comments;
        commentList[index].reply.add(result);
        emit(CommentSent());
        emit(AllCommentsFetched(comments: commentList));
      }
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  Future<void> videoLikeDislikeComment(
      String commentId, int index, bool parent) async {
    try {
      var data = FormData.fromMap({
        'comment_id': commentId,
      });

      final currentState = state;
      if (currentState is AllCommentsFetched) {
        List<CommentModel> commentList = currentState.comments;

        if (parent) {
          CommentModel commentModel = commentList[index];
          if (commentModel.isLiked) {
            commentList[index].userLiked.remove(AuthRepo.instance.user);
            commentList[index].userLikedCount =
                commentList[index].userLikedCount - 1;
            commentModel.isLiked = false;
          } else {
            commentList[index].userLiked.add(AuthRepo.instance.user);
            commentList[index].userLikedCount =
                commentList[index].userLikedCount + 1;
            commentModel.isLiked = true;
            emit(CommentLikedDisliked(message: 'Liked'));
          }
        } else {
          CommentModel commentModel = commentList[index]
              .reply
              .firstWhere((element) => element.id == commentId);
          if (commentModel.isLiked) {
            commentModel.userLiked.remove(AuthRepo.instance.user);
            commentModel.isLiked = false;
            commentModel.userLikedCount = commentModel.userLikedCount - 1;
          } else {
            commentModel.userLiked.add(AuthRepo.instance.user);
            commentModel.isLiked = true;
            commentModel.userLikedCount = commentModel.userLikedCount + 1;
            emit(CommentLikedDisliked(message: 'Liked'));
          }
        }

        emit(AllCommentsFetched(comments: commentList));
      }

      await VideoRepo.instance.videoLikeDislikeCommentApi(data);
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }
}
