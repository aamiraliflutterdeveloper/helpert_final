import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/video/model/videos_model.dart';
import 'package:helpert_app/features/video/repo/video_repo.dart';

import 'fetch_user_video_state.dart';

class FetchUserVideoBloc extends Cubit<FetchUserVideoState> {
  FetchUserVideoBloc() : super(InitialState());

  Future<void> fetchCurrentUserVideo() async {
    emit(FetchUserVideoLoading());
    try {
      AllVideosModel result =
          await VideoRepo.instance.fetchCurrentUserVideoApi();
      // if (result.videos_list.isNotEmpty)
      emit(FetchUserVideoLoaded(currentUserVideos: result));
    } catch (e) {
      emit(FetchUserVideoError(e.toString()));
    }
  }

  Future<void> videoLikeDislike(
      int? videoBotId,
      // int? videoQuestionId,
      int videoBotIndex,
      // int? videoQuestionIndex,
      List<VideoBotModel> botList) async {
    try {
      var data = FormData.fromMap({
        'video_bots_id': videoBotId,
      });

      await VideoRepo.instance.videoLikeDislikeApi(data);
    } catch (e) {
      emit(FetchUserVideoError(e.toString()));
    }
  }
}
