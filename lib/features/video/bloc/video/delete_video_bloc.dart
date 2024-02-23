import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/video/repo/video_repo.dart';

import 'delete_video_state.dart';

class DeleteVideoBloc extends Cubit<DeleteVideoState> {
  DeleteVideoBloc() : super(InitialState());

  deleteVideo(int? videoId) async {
    emit(DeleteVideoLoading());
    try {
      var data = FormData.fromMap({
        'video_bots_id': videoId,
        'question_video_id': null,
      });
       await VideoRepo.instance.deleteVideoApi(data);
      emit(DeleteVideoLoaded());
    } catch (e) {
      emit(DeleteVideoError(e.toString()));
    }
  }
}
