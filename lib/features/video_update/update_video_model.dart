// To parse this JSON data, do
//
//     final updateVideoModel = updateVideoModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';

UpdateVideoModel updateVideoModelFromJson(String str) =>
    UpdateVideoModel.fromJson(json.decode(str));

String updateVideoModelToJson(UpdateVideoModel data) =>
    json.encode(data.toJson());

class UpdateVideoModel {
  UpdateVideoModel({
    required this.video_bot_id,
    required this.mainTitle,
    this.introVideo,
    required this.interestId,
    this.defaultVideo,
    required this.videoBotsQuestion,
  });
  int video_bot_id;
  String mainTitle;
  MultipartFile? introVideo;
  int interestId;
  MultipartFile? defaultVideo;
  List<VideoBotsQuestion> videoBotsQuestion;
  factory UpdateVideoModel.fromJson(Map<String, dynamic> json) =>
      UpdateVideoModel(
        mainTitle: json["main_title"],
        introVideo: json["intro_video"],
        interestId: json["interest_id"],
        defaultVideo: json["default_video"],
        video_bot_id: json["video_bot_id"],
        videoBotsQuestion: List<VideoBotsQuestion>.from(
            json["video_bots_question"]
                .map((x) => VideoBotsQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "main_title": mainTitle,
        "intro_video": introVideo,
        "interest_id": interestId,
        "default_video": defaultVideo,
        "video_bot_id": video_bot_id,
        "video_bots_question":
            List<dynamic>.from(videoBotsQuestion.map((x) => x.toJson())),
      };
}

class VideoBotsQuestion {
  VideoBotsQuestion({
    required this.id,
    required this.question,
    this.video,
    this.deleteId,
  });

  int id;
  String question;
  MultipartFile? video;
  int? deleteId;

  factory VideoBotsQuestion.fromJson(Map<String, dynamic> json) =>
      VideoBotsQuestion(
        id: json["id"],
        question: json["question"],
        video: json["video"],
        deleteId: json["delete_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "video": video,
        "delete_id": deleteId,
      };
}
