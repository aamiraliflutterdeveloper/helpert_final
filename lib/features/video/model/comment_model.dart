import 'package:helpert_app/features/auth/models/user_model.dart';

class CommentModel {
  CommentModel({
    required this.userId,
    required this.id,
    required this.videoBotsId,
    required this.videoBotQuestionId,
    required this.comment,
    required this.createdAt,
    required this.userLikedCount,
    required this.user,
    required this.isLiked,
    required this.reply,
    required this.userLiked,
  });

  String id;
  String userId;
  int videoBotsId;
  int videoBotQuestionId;
  String comment;
  String createdAt;
  int userLikedCount;
  bool isLiked;
  UserModel user;
  List<CommentModel> reply;
  List<UserModel> userLiked;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"].toString(),
        userId: json["user_id"].toString(),
        videoBotsId: json["video_bots_id"] ?? '',
        videoBotQuestionId: json["video_bot_question_id"] ?? '',
        comment: json["comment"],
        createdAt: json["created_at"],
        isLiked: json["is_liked"] ?? false,
        user: UserModel.fromJson(json["user"]),
        userLikedCount:
            json["user_liked_count"] ?? 0,
        reply: json["reply"] == null
            ? []
            : List<CommentModel>.from(
                json["reply"].map((x) => CommentModel.fromJson(x))),
        userLiked: json["user_liked"] == null
            ? []
            : List<UserModel>.from(
                json["user_liked"].map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "video_bots_id": videoBotsId,
        "video_bot_question_id": videoBotQuestionId,
        "comment": comment,
        "user_liked_count": userLikedCount,
        "user": user.toJson(),
        "reply": List<dynamic>.from(reply.map((x) => x.toJson())),
        "user_liked": List<dynamic>.from(userLiked.map((x) => x.toJson())),
      };
}
