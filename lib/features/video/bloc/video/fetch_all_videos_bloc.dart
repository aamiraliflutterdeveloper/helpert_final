import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/video/bloc/video/fetch_all_videos_state.dart';
import 'package:helpert_app/features/video/model/videos_model.dart';
import 'package:helpert_app/features/video/repo/video_repo.dart';

class FetchAllVideosBloc extends Cubit<FetchAllVideoState> {
  FetchAllVideosBloc() : super(InitialState());
  AllVideosModel? allVideosModel;

  Future<void> fetchAllVideos({
    isRefreshing = false,
    isLoading = true,
    required int currentPage,
    required int limit,
  }) async {
    if (isLoading) emit(FetchAllVideoLoading());
    try {
      var data = {
        'page': currentPage,
        'per_page': limit,
      };

      final currentState = state;
      if (currentState is FetchAllVideoLoaded) {
        List<VideoBotModel> currentVideos =
            isRefreshing ? [] : currentState.allVideos.videos_list;

        AllVideosModel result =
            await VideoRepo.instance.fetchAllVideosApi(data);

        currentVideos.addAll(result.videos_list);

        result.videos_list = currentVideos;
        if (isRefreshing) {
          result.videos_list = result.videos_list.reversed.toList();
        }

        if (result.videos_list.isNotEmpty) allVideosModel = result;
        emit(FetchAllVideoLoaded(allVideos: result));
      } else {
        AllVideosModel result =
            await VideoRepo.instance.fetchAllVideosApi(data);
        if (result.videos_list.isNotEmpty) allVideosModel = result;
        result.videos_list = result.videos_list.reversed.toList();
        emit(FetchAllVideoLoaded(allVideos: result));
      }
    } catch (e) {
      emit(FetchAllVideoError(e.toString()));
    }
  }

  Future<List<VideoBotModel>> fetchAllVideosLink({
    required int currentPage,
    required int limit,
  }) async {
    try {
      var data = {
        'page': currentPage,
        'per_page': limit,
      };

      AllVideosModel result = await VideoRepo.instance.fetchAllVideosApi(data);
      return result.videos_list;

      return result.videos_list;
    } catch (e) {
      return [];
    }
  }

  // Future<void> videoLikeDislike(
  //     int? videoBotId,
  //     int? videoQuestionId,
  //     int videoBotIndex,
  //     int? videoQuestionIndex,
  //     List<VideoBotModel> botList) async {
  //   try {
  //     var data = FormData.fromMap({
  //       'video_bots_id': videoBotId,
  //       'video_bot_question_id': videoQuestionId,
  //     });
  //     var currentState = state;
  //     if (currentState is FetchAllVideoLoaded) {
  //       AllVideosModel allVideos = currentState.allVideos;
  //
  //       if (videoBotId != null) {
  //         if (botList[videoBotIndex].isVideoLiked) {
  //           botList[videoBotIndex].isVideoLiked = false;
  //           botList[videoBotIndex].likeCount =
  //               botList[videoBotIndex].likeCount - 1;
  //         } else {
  //           botList[videoBotIndex].isVideoLiked = true;
  //           botList[videoBotIndex].likeCount =
  //               botList[videoBotIndex].likeCount + 1;
  //         }
  //       } else {
  //         if (botList[videoBotIndex]
  //             .video_question[videoQuestionIndex!]
  //             .isVideoLiked) {
  //           botList[videoBotIndex]
  //               .video_question[videoQuestionIndex]
  //               .isVideoLiked = false;
  //           botList[videoBotIndex]
  //               .video_question[videoQuestionIndex]
  //               .likeCount = botList[videoBotIndex]
  //                   .video_question[videoQuestionIndex]
  //                   .likeCount -
  //               1;
  //         } else {
  //           botList[videoBotIndex]
  //               .video_question[videoQuestionIndex]
  //               .isVideoLiked = true;
  //           botList[videoBotIndex]
  //               .video_question[videoQuestionIndex]
  //               .likeCount = botList[videoBotIndex]
  //                   .video_question[videoQuestionIndex]
  //                   .likeCount +
  //               1;
  //         }
  //       }
  //       allVideos.videos_list = botList;
  //       emit(FetchAllVideoLoaded(allVideos: allVideos));
  //     }
  //     await VideoRepo.instance.videoLikeDislikeApi(data);
  //   } catch (e) {
  //     emit(FetchAllVideoError(e.toString()));
  //   }
  // }
  Future<void> sendNotification({
    required int doctorId,
    String? type,
  }) async {
    try {
      var data = FormData.fromMap({
        'doctor_id': doctorId,
        'notification_type': type,
      });
      debugPrint('$doctorId');
      debugPrint(type);
      await VideoRepo.instance.sendNotificationApi(data);
    } catch (e) {
      debugPrint('$e');
    }
  }

  tabsVideos({String? name}) {
    if (allVideosModel != null && allVideosModel!.videos_list.isNotEmpty) {
      if (name != null) {
        var sortedVideos = allVideosModel!.videos_list.where((element) {
          List<int> interestIds = [];
          if (AuthRepo.instance.user.interests.isNotEmpty) {
            for (var element in AuthRepo.instance.user.interests) {
              interestIds.add(element.id);
            }
          }
          if (element.specialization.isNotEmpty) {
            return element.specialization == name &&
                interestIds.contains(element.interest!.id);
          } else {
            return '' == name;
          }
        }).toList();
        emit(FetchAllVideoLoaded(
            allVideos: AllVideosModel(videos_list: sortedVideos)));
      } else {
        emit(FetchAllVideoLoaded(allVideos: allVideosModel!));
      }
    }
  }
}
