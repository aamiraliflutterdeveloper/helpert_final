import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

import '../../features/video/model/carousel_model.dart';

class VideoModule {
  static List videoList = [];
  static List updateVideoList = [];
  static List interestID = [];
  static List introVideo = [];
  static List defaultVideo = [];
  static List topic = [];
  static List video_bot_id = [];
  static List questionVideosIds = [];
  static List deleteQuestionVideoIds = [];
  static List categoryList = [];
  static List<String> videoQuestions = [];
  static var nameTECs = <TextEditingController>[];
  static List<int> indexes = [0];
  static List<XFile> sliderVideosList = [];
  static List<VideoListData> dataList = [];
  static List videoBotId = [];
  static List<String> questionPublish = [];
}

clearVideoModuleLists() {
  VideoModule.videoList.clear();
  VideoModule.videoQuestions.clear();
  VideoModule.nameTECs.clear();
  VideoModule.indexes.clear();
  VideoModule.video_bot_id.clear();
  VideoModule.questionVideosIds.clear();
  VideoModule.updateVideoList.clear();
  VideoModule.indexes = [0];
  VideoModule.sliderVideosList.clear();
  VideoModule.videoBotId.clear();
  VideoModule.questionPublish.clear();
  VideoModule.introVideo.clear();

  // VideoModule.nameTECs.add(TextEditingController());
  VideoModule.defaultVideo.clear();
}
