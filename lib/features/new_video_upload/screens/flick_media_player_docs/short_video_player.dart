import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/new_video_upload/screens/flick_media_player_docs/reuseable_video_list_controller.dart';

import '../../../video/model/videos_model.dart';
import '../../bloc/video_view_bloc.dart';
import 'flick_multi_player.dart';

class ShortVideoPlayer extends StatefulWidget {
  final List<VideoBotModel> videoList;
  final int listIndex;
  const ShortVideoPlayer(
      {Key? key, required this.videoList, required this.listIndex})
      : super(key: key);

  @override
  ShortVideoPlayerState createState() => ShortVideoPlayerState();
}

class ShortVideoPlayerState extends State<ShortVideoPlayer> {
  ReusableVideoListController videoListController =
      ReusableVideoListController();

  var value = 0;
  int lastMilli = DateTime.now().millisecondsSinceEpoch;
  bool _canBuildVideo = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getVideoViews();
    });
  }

  int currentVideoBotID = -1;
  int videoViews = 0;

  getVideoViews() {
    if (mounted && widget.videoList[currentVideoBotID].is_video_view == false) {
      context.read<VideoViewBloc>().videoView(
          videoBotId: widget.videoList[currentVideoBotID].video_bots_id,
          videoQuestionId: null);
    }
    videoViews = widget.videoList[currentVideoBotID].video_view_count;
    if (widget.videoList[currentVideoBotID].is_video_view == false) {
      videoViews += 1;
      setState(() {});
    }
    setState(() {});
  }

  VideoBotModel? currentIndex;
  late PageController pageController =
      PageController(initialPage: widget.listIndex);

  @override
  void dispose() {
    videoListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
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
        controller: pageController,
        scrollDirection: Axis.vertical,
        itemCount: widget.videoList.length,
        onPageChanged: (val) {
          getVideoViews();
          setState(() {});
        },
        itemBuilder: (context, index) {
          currentVideoBotID = index;
          currentIndex = widget.videoList[index];
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FlickMultiPlayer(
                videoListController: videoListController,
                canBuildVideo: _checkCanBuildVideo,
                videoList: widget.videoList,
                index: index,
                videoViews: videoViews,
                listIndex: widget.listIndex,
                // url: videosList[index],
                url: widget.videoList[index].video,
                // url: items[index],
                currentIndex: currentIndex,
                // image: shortVideoMockData['items'][index]['image'],
              ));
        },
      ),
    );
  }

  bool _checkCanBuildVideo() {
    return _canBuildVideo;
  }
}
