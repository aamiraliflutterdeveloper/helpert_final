import 'package:flutter/material.dart';
import 'package:helpert_app/features/new_video_upload/reusable_video_list/reusable_video_list_widget.dart';
import 'package:helpert_app/features/video/model/videos_model.dart';

import '../screens/flick_media_player_docs/reuseable_video_list_controller.dart';

class ReusableVideoListPage extends StatefulWidget {
  final List<VideoBotModel> videoList;
  const ReusableVideoListPage({Key? key, required this.videoList})
      : super(key: key);

  @override
  _ReusableVideoListPageState createState() => _ReusableVideoListPageState();
}

class _ReusableVideoListPageState extends State<ReusableVideoListPage> {
  ReusableVideoListController videoListController =
      ReusableVideoListController();
  // final _random = new Random();
  // final List<String> _videos = [
  //   'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
  //   'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
  //   'https://github.com/tinusneethling/betterplayer/raw/ClearKeySupport/example/assets/testvideo_encrypt.mp4',
  //   'https://github.com/tinusneethling/betterplayer/raw/ClearKeySupport/example/assets/testvideo_encrypt.mp4',
  //   'http://34.226.5.179/introvideo/videos/1665659589.1665659609776.mp4',
  //   'http://34.226.5.179/introvideo/videos/1665661337.1665661073172.mp4',
  //   'http://34.226.5.179/introvideo/videos/1665662522.1665662496327.mp4',
  //   'http://34.226.5.179/introvideo/videos/1665663262.1665663225592.mp4',
  //   'http://34.226.5.179/introvideo/videos/1665663981.1665664000994.mp4',
  //   'http://34.226.5.179/introvideo/videos/1665665553.1665665489989.mp4',
  //   'http://34.226.5.179/introvideo/videos/1665727325.1665727309529.mp4',
  // ];
  // List<VideoListData2> dataList = [];
  var value = 0;
  int lastMilli = DateTime.now().millisecondsSinceEpoch;
  bool _canBuildVideo = true;

  @override
  void initState() {
    // _setupData();
    super.initState();
  }

  // void _setupData() {
  //   dataList.clear();
  //   for (int index = 0; index < 10; index++) {
  //     var randomVideoUrl = _videos[_random.nextInt(_videos.length)];
  //     dataList.add(VideoListData2("Video $index", randomVideoUrl));
  //   }
  // }

  @override
  void dispose() {
    videoListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Column(children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                final now = DateTime.now();
                final timeDiff = now.millisecondsSinceEpoch - lastMilli;
                if (notification is ScrollUpdateNotification) {
                  final pixelsPerMilli = notification.scrollDelta! / timeDiff;
                  if (pixelsPerMilli.abs() > 1) {
                    _canBuildVideo = false;
                  } else {
                    _canBuildVideo = true;
                  }
                  lastMilli = DateTime.now().millisecondsSinceEpoch;
                }
                if (notification is ScrollEndNotification) {
                  _canBuildVideo = true;
                  lastMilli = DateTime.now().millisecondsSinceEpoch;
                }
                return true;
              },
              child: PageView.builder(
                onPageChanged: (val) {
                  setState(() {});
                },
                itemCount: widget.videoList.length,
                // controller: _scrollController,
                itemBuilder: (context, index) {
                  VideoBotModel videoListData = widget.videoList[index];
                  return ReusableVideoListWidget(
                    videoListData: videoListData,
                    videoListController: videoListController,
                    canBuildVideo: _checkCanBuildVideo,
                  );
                },
              ),
            ),
          )
        ]),
      ),
    );
  }

  bool _checkCanBuildVideo() {
    return _canBuildVideo;
  }
}

class VideoListData2 {
  final String videoTitle;
  final String videoUrl;
  Duration? lastPosition;
  bool? wasPlaying = false;

  VideoListData2(this.videoTitle, this.videoUrl);
}
