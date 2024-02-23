import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/core/data/video_data.dart';
import 'package:helpert_app/features/video_update/bloc/update_video_state.dart';
import 'package:helpert_app/features/video_update/update_video_model.dart';

import '../repo/update_video_repo.dart';

class UpdateVideoBloc extends Cubit<UpdateVideoState> {
  UpdateVideoBloc() : super(InitialState());

  //List<ListItem> interests = [];

  Future<void> updateVideo(
      int categoryId,
      String defaultVideo,
      String introVide,
      List videos,
      List<String> questions,
      String mainTitle) async {
    emit(UpdateVideoLoading());

    try {
      List<MultipartFile?> reBots = [];
      MultipartFile? requiredVideo;
      MultipartFile? introVideoFile;
      MultipartFile? defaultVideoFile;

      for (var a = 0; a < videos.length; a++) {
        var data = getFirstWord(videos[a]);
        if (data != 'https://helpert.cyberasol') {
          String fileName = videos[a].split('/').last;
          requiredVideo =
              await MultipartFile.fromFile(videos[a], filename: fileName);
        }
        if (data == 'https://helpert.cyberasol') {
          reBots.add(null);
        } else {
          reBots.add(requiredVideo);
        }
      }

      /// intro video
      var checkIntroType = getFirstWord(introVide);
      if (checkIntroType != 'https://helpert.cyberasol') {
        String introFileName = introVide.split('/').last;
        introVideoFile =
            await MultipartFile.fromFile(introVide, filename: introFileName);
      }

      /// default video
      var checkDefaultType = getFirstWord(defaultVideo);
      if (checkDefaultType != 'https://helpert.cyberasol') {
        String defaultVideoName = defaultVideo.split('/').last;
        defaultVideoFile = await MultipartFile.fromFile(defaultVideo,
            filename: defaultVideoName);
      }

      List<VideoBotsQuestion> videoBotsQuestion = [];
      for (var a = 0; a < VideoModule.videoQuestions.length; a++) {
        videoBotsQuestion.add(VideoBotsQuestion(
            id: VideoModule.questionVideosIds[a],
            question: VideoModule.videoQuestions[a],
            video: reBots[a],
            deleteId: VideoModule.deleteQuestionVideoIds[a]));
      }

      UpdateVideoModel updateVideoModel = UpdateVideoModel(
          mainTitle: mainTitle,
          video_bot_id: 137,
          interestId: 1,
          defaultVideo: defaultVideoFile,
          introVideo: introVideoFile,
          videoBotsQuestion: videoBotsQuestion);
      var data = FormData.fromMap(updateVideoModel.toJson());
      bool result = await UpdateVideoRepo.instance.updateVideoApi(data);
      if (result) emit(UpdateVideoLoaded());
    } catch (e) {
      emit(UpdateVideoError(e.toString()));
    }
  }

  /// check video contains http or not
  String getFirstWord(String inputString) {
    List<String> wordList = inputString.split('.com/');
    if (wordList.isNotEmpty) {
      return wordList[0];
    } else {
      return '';
    }
  }
}
