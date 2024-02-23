import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/video/model/videos_model.dart';

import '../repo/other_profile_repo.dart';
import 'other_profile_video_state.dart';

class OtherProfileVideoBloc extends Cubit<OtherProfileVideoState> {
  OtherProfileVideoBloc() : super(InitialState());

  Future<void> fetchOtherProfileVideos(int userId) async {
    emit(OtherProfileVideoLoading());
    try {
      var data = FormData.fromMap({
        'user_id': userId,
      });
      AllVideosModel result =
          await OtherProfileRepo.instance.fetchOtherProfileVideoApi(data);

      emit(OtherProfileVideoLoaded(otherUserVideos: result));
    } catch (e) {
      emit(OtherProfileVideoError(e.toString()));
    }
  }
}
