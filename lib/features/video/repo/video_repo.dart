import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/core/data/video_data.dart';
import 'package:helpert_app/features/auth/models/user_model.dart';
import 'package:helpert_app/features/video/model/all_list_model.dart';
import 'package:helpert_app/features/video/model/comment_model.dart';
import 'package:helpert_app/features/video/model/recommeded_question_model.dart';
import 'package:helpert_app/features/video/model/videos_model.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/models/api_response.dart';
import '../../../core/services/rest_api_service.dart';

class VideoRepo {
  VideoRepo.privateConstructor();
  static final VideoRepo instance = VideoRepo.privateConstructor();

  Future<bool> publishVideoApi(FormData formData,
      Function(int senderValue, int receiverValue) videoStatus) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kPublishVideoApi,
      formData: formData,
      videoStatus: videoStatus,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      var id = apiResponse.data['id'];
      VideoModule.videoBotId.add(id);
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> shareVideoApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kShareVideoApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> videoLikeDislikeApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kVideosLikeApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<List<ListItem>> allInterestApi() async {
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      kInterestApi,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return List.from(apiResponse.data)
          .map((e) => ListItem.fromJson(e))
          .toList();
    } else {
      throw apiResponse.message!;
    }
  }

  Future<AllVideosModel> fetchAllVideosApi(
      Map<String, dynamic> formData) async {
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      kFetchAllVideosApi,
      queryParams: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      AllVideosModel allVideosModel = AllVideosModel.fromJson(apiResponse.data);
      return allVideosModel;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<AllVideosModel> fetchCurrentUserVideoApi() async {
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      kFetchCurrentUserVideoApi,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      AllVideosModel allVideosModel = AllVideosModel.fromJson(apiResponse.data);
      SharedVideosModel sharedVideosModel =
          SharedVideosModel.fromJson(apiResponse.data);
      allVideosModel.videos_list.addAll(sharedVideosModel.shared_videos_list);

      return allVideosModel;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<CommentModel> videoCreateCommentApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kCreateVideoCommentApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return CommentModel.fromJson(apiResponse.data);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<void> sendNotificationApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kSendNotificationApi,
      formData: formData,
      isTokenRequired: true,
    );
    debugPrint(apiResponse.result);
    debugPrint("=====");
    if (apiResponse.result == 'success') {
    } else {
      throw apiResponse.message!;
    }
  }

  Future<CommentModel> videoReplyCommentApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kReplyCommentsApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return CommentModel.fromJson(apiResponse.data);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<UserModel> videoLikeDislikeCommentApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kLikeDislikeCommentApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return UserModel.fromJson(apiResponse.data);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<List<CommentModel>> getVideoCommentsApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kGetVideoCommentsApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      List<CommentModel> commentList = List<CommentModel>.from(
          apiResponse.data.map((x) => CommentModel.fromJson(x)));
      return commentList;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<void> deleteVideoApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KDeleteVideoApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
    } else {
      throw apiResponse.message!;
    }
  }

  Future<List<RecommendedQuestionModel>> getRecommendedQuestionsApi() async {
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      kRecommendedQuestionsApi,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return List.from(apiResponse.data)
          .map((e) => RecommendedQuestionModel.fromJson(e))
          .toList();
    } else {
      throw apiResponse.message!;
    }
  }

  Future<AllListModel> getAllListApi() async {
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      kAllListApi,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return AllListModel.fromJson(apiResponse.data);
    } else {
      throw apiResponse.message!;
    }
  }

  /// video views Api
  Future<bool> videoViewApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      KVideoViewsApi,
      formData: formData,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      return true;
    } else {
      throw apiResponse.message!;
    }
  }
}
