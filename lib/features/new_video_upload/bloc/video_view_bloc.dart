import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/new_video_upload/bloc/video_view_state.dart';

import '../../video/repo/video_repo.dart';

class VideoViewBloc extends Cubit<VideoViewState> {
  VideoViewBloc() : super(InitialState());
  Future<void> videoView({int? videoBotId, int? videoQuestionId}) async {
    try {
      var data = FormData.fromMap({
        'video_bots_id': videoBotId,
        'video_bot_question_id': videoQuestionId,
      });
      await VideoRepo.instance.videoViewApi(data);
      emit(VideoViewLoaded());
    } catch (e) {
      emit(VideoViewError(e.toString()));
    }
  }
}
