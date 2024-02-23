import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/video/bloc/video/share_video_state.dart';
import 'package:helpert_app/features/video/repo/video_repo.dart';

class ShareVideoBloc extends Cubit<ShareVideoState> {
  ShareVideoBloc() : super(InitialState());

  Future<void> shareVideo(int videoBotId) async {
    emit(ShareVideoLoading());
    try {
      var data = FormData.fromMap({
        'video_bot_id': videoBotId,
      });
      bool result = await VideoRepo.instance.shareVideoApi(data);
      if (result) emit(ShareVideoLoaded());
    } catch (e) {
      emit(ShareVideoError(e.toString()));
    }
  }
}
