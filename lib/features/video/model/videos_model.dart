import 'package:helpert_app/features/auth/models/user_model.dart';

class SharedVideosModel {
  SharedVideosModel({
    required this.shared_videos_list,
  });

  List<VideoBotModel> shared_videos_list;

  factory SharedVideosModel.fromJson(Map<String, dynamic> json) =>
      SharedVideosModel(
        shared_videos_list: List<VideoBotModel>.from(json["shared_videos_list"]
            .map((x) => VideoBotModel.fromJson(x))).reversed.toList(),
      );
}

class AllVideosModel {
  AllVideosModel({
    required this.videos_list,
  });

  List<VideoBotModel> videos_list;

  factory AllVideosModel.fromJson(Map<String, dynamic> json) => AllVideosModel(
        videos_list: List<VideoBotModel>.from(
                json["videos_list"].map((x) => VideoBotModel.fromJson(x)))
            .reversed
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "videos_list": List<dynamic>.from(videos_list.map((x) => x.toJson())),
      };
}

class VideoBotModel {
  VideoBotModel({
    required this.user_id,
    required this.user_name,
    required this.firstName,
    required this.lastName,
    required this.sessionRate,
    required this.paymentStatus,
    required this.timezone,
    required this.user_image,
    required this.specialization,
    required this.video_bots_id,
    required this.commentsCount,
    required this.likeCount,
    required this.main_title,
    required this.video,
    this.interest,
    this.isVideoLiked = false,
    required this.image,
    this.isFollow = 0,
    required this.video_view_count,
    required this.is_video_view,
    this.lastPosition,
    this.wasPlaying,
  });

  int user_id;
  String user_name;
  String firstName;
  String lastName;
  int sessionRate;
  String paymentStatus;
  String timezone;
  String user_image;
  String specialization;
  int video_bots_id;
  int commentsCount;
  int likeCount;
  String main_title;
  String video;
  ListItem? interest;
  bool isVideoLiked;
  String image;
  int isFollow;
  int video_view_count;
  bool is_video_view;
  Duration? lastPosition;
  bool? wasPlaying = false;

  factory VideoBotModel.fromJson(Map<String, dynamic> json) => VideoBotModel(
        user_id: json["user_id"] ?? '',
        user_name: json["user_name"] ?? '',
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        sessionRate: json["session_rate"] ?? 0,
        paymentStatus: json["payment_status"] ?? '',
        timezone: json["timezone"] ?? '',
        user_image: json["user_image"] ?? '',
        commentsCount: json["total_comment"] ?? 0,
        likeCount: json["video_like_count"] ?? 0,
        specialization: json["specialization"] ?? '',
        video_bots_id: json["video_bots_id"] ?? '',
        main_title: json["main_title"] ?? '',
        video: json["video"] ?? '',
        interest: json["interest"] != null
            ? ListItem.fromJson(json["interest"])
            : null,
        isVideoLiked: json["is_video_liked"] ?? false,
        image: json["image"] ?? '',
        isFollow: json['is_follow'] ?? 0,
        video_view_count: json['video_view_count'] ?? 0,
        is_video_view: json["is_video_view"] ?? false,
        lastPosition: json["lastPosition"],
        wasPlaying: json["wasPlaying"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "user_name": user_name,
        "user_image": user_image,
        "specialization": specialization,
        "video_bots_id": video_bots_id,
        "main_title": main_title,
        "video": video,
        "is_video_liked": isVideoLiked,
        "image": image,
        'is_follow': isFollow,
      };
}
