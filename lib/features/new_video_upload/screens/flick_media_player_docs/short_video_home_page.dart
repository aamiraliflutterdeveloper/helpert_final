import 'package:better_player/better_player.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../common_widgets/components/text_view.dart';
import '../../../../common_widgets/fetch_svg.dart';
import '../../../../constants/api_endpoints.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/text_styles.dart';
import '../../../../core/services/dynamic_links/dynamic_links.dart';
import '../../../../utils/nav_router.dart';
import '../../../auth/repo/auth_repo.dart';
import '../../../other_user_profile/screens/other_profile_screen.dart';
import '../../../profile/profile_screen.dart';
import '../../../reusable_video_list/app_data.dart';
import '../../../video/bloc/comment/comment_bloc.dart';
import '../../../video/bloc/comment/comment_state.dart';
import '../../../video/bloc/video/fetch_all_videos_bloc.dart';
import '../../../video/model/comment_model.dart';
import '../../../video/model/videos_model.dart';
import '../../../video/videobots/widgets/videobot_profile_widget.dart';
import '../../../video/videobots/widgets/videobot_topbar.dart';
import '../../../video/widget/comment_textfield.dart';
import '../../../video/widget/comment_tree_widget.dart';
import '../../../video/widget/tree_theme_data.dart';
import '../../bloc/fetch_user_video_bloc.dart';
import '../../bloc/video_view_bloc.dart';
import '../../reusable_video_list/reusable_video_list_page.dart';
import 'custom_controls_widget.dart';

class ShortVideoHomePage extends StatefulWidget {
  final String route;
  int listIndex;
  int currentPage;
  int? videoBotId;
  final List<VideoBotModel> videoList;
  ShortVideoHomePage(
      {Key? key,
      required this.videoList,
      required this.route,
      required this.listIndex,
      this.currentPage = 1,
      this.videoBotId})
      : super(key: key);

  @override
  _ShortVideoHomePageState createState() => _ShortVideoHomePageState();
}

class _ShortVideoHomePageState extends State<ShortVideoHomePage> {
  List<VideoListData2> dataList = [];

  BetterPlayerListVideoPlayerController? controller;
  late BetterPlayerConfiguration betterPlayerConfiguration;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    if (widget.videoBotId != null) {
      widget.listIndex = widget.videoList.indexOf(widget.videoList
          .where((element) => element.video_bots_id == widget.videoBotId)
          .first);
    }
    controller = BetterPlayerListVideoPlayerController()
      ..setMixWithOthers(true);
    betterPlayerConfiguration = BetterPlayerConfiguration(
      autoPlay: true,
    );
  }

  BetterPlayerController? betterPlayerController;

  // @override
  // void dispose() {
  //   super.dispose();
  //   controller?.pause();
  //   // controller.setBetterPlayerController(betterPlayerController?.dispose());
  //   controller = null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: BuildPageView(
        currentPage: widget.currentPage,
        videos: widget.videoList,
        controller: controller,
        listIndex: widget.listIndex,
      ),
    );
  }
}

class BuildPageView extends StatefulWidget {
  List<VideoBotModel> videos;
  final BetterPlayerListVideoPlayerController? controller;
  final int listIndex;
  int currentPage;
  BuildPageView({
    Key? key,
    required this.videos,
    required this.controller,
    required this.listIndex,
    required this.currentPage,
  }) : super(key: key);

  @override
  State<BuildPageView> createState() => _BuildPageViewState();
}

class _BuildPageViewState extends State<BuildPageView> {
  int currentVideoBotID = -1;
  VideoBotModel? currentIndex;
  int videoViews = 0;

  int limit = 10;
  late PageController pageController =
      PageController(initialPage: widget.listIndex);
  bool isLoading = false;
  @override
  initState() {
    super.initState();
    pageController.addListener(() async {
      if (pageController.position.maxScrollExtent ==
          pageController.position.pixels) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });
        }
        widget.videos.addAll(await context
            .read<FetchAllVideosBloc>()
            .fetchAllVideosLink(currentPage: widget.currentPage, limit: limit));
        widget.currentPage++;
        isLoading = false;
        setState(() {});
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getVideoViews();
    });
  }

  getVideoViews() {
    if (mounted && widget.videos[currentVideoBotID].is_video_view == false) {
      context.read<VideoViewBloc>().videoView(
          videoBotId: widget.videos[currentVideoBotID].video_bots_id,
          videoQuestionId: null);
    }
    videoViews = widget.videos[currentVideoBotID].video_view_count;
    if (widget.videos[currentVideoBotID].is_video_view == false) {
      videoViews += 1;
      setState(() {});
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (va) {
                getVideoViews();
              },
              scrollDirection: Axis.vertical,
              itemCount: widget.videos.length,
              itemBuilder: (context, index) {
                currentVideoBotID = index;
                currentIndex = widget.videos[index];
                String url = widget.videos[index].video;
                return BetterWidget(
                  url: url,
                  controller: widget.controller,
                  index: index,
                  currentIndex: currentIndex,
                  listIndex: widget.listIndex,
                  videoViews: videoViews,
                  videos: widget.videos,
                  isLoading: isLoading,
                );
              },
            ),
          ),
          if (isLoading)
            SizedBox(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(strokeWidth: 3.0)),
        ],
      ),
    );
  }
}

class BetterWidget extends StatefulWidget {
  BetterWidget({
    Key? key,
    required this.url,
    required this.controller,
    required this.index,
    required this.currentIndex,
    required this.videoViews,
    required this.listIndex,
    required this.videos,
    required this.isLoading,
  }) : super(key: key);

  final String url;
  BetterPlayerListVideoPlayerController? controller;
  final int index;
  final VideoBotModel? currentIndex;
  final List<VideoBotModel> videos;
  final int videoViews;
  final int listIndex;
  final bool isLoading;

  @override
  State<BetterWidget> createState() => _BetterWidgetState();
}

class _BetterWidgetState extends State<BetterWidget>
    with SingleTickerProviderStateMixin {
  int isFollowing = 0;
  late AnimationController animationController;

  @override
  initState() {
    super.initState();
    animationController = BottomSheet.createAnimationController(this);
    animationController.duration = const Duration(milliseconds: 400);
  }

  late BetterPlayerConfiguration betterPlayerConfiguration;
  // @override
  // void dispose() {
  //   super.dispose();
  //   widget.controller?.pause();
  // }
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: (val) {
        if (val.visibleFraction >= .8) {
          widget.controller?.play();
          // } else {
          //   if (widget.controller != null) {
          //     widget.controller?.pause();
          //   }
        }
      },
      key: Key(hashCode.toString() + DateTime.now().toString()),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BetterPlayerListVideoPlayer(
              BetterPlayerDataSource(
                BetterPlayerDataSourceType.network,
                '$VIDEO_BASE_URL${widget.url}',
                notificationConfiguration:
                    BetterPlayerNotificationConfiguration(
                        showNotification: false,
                        title: 'videoListData videoTitle',
                        author: "Test"),
                bufferingConfiguration: BetterPlayerBufferingConfiguration(
                    minBufferMs: 2000,
                    maxBufferMs: 10000,
                    bufferForPlaybackMs: 1000,
                    bufferForPlaybackAfterRebufferMs: 2000),
              ),
              configuration: BetterPlayerConfiguration(
                  autoDispose: true,
                  looping: true,
                  autoPlay: true,
                  aspectRatio: .5,
                  handleLifecycle: true,
                  controlsConfiguration: BetterPlayerControlsConfiguration(
                    playerTheme: BetterPlayerTheme.custom,
                    customControlsBuilder:
                        (controller, onControlsVisibilityChanged) =>
                            CustomControlsWidget(
                      controller: controller,
                      onControlsVisibilityChanged: onControlsVisibilityChanged,
                    ),
                  )),
              key: Key('videoListData${widget.url}'.hashCode.toString()),
              playFraction: 0.9,
              betterPlayerListVideoPlayerController: widget.controller,
            ),
          ),
          VideoBotTopBar(
              isFollowing: isFollowing,
              videoViews: widget.videoViews,
              currentIndex: widget.currentIndex),
          // Align(
          //     child: CircularProgressIndicator(), alignment: Alignment.center),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0) + EdgeInsets.only(top: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<FetchUserVideoBloc>().videoLikeDislike(
                          widget.currentIndex!.video_bots_id,
                          widget.index,
                          widget.videos);
                      if (widget.currentIndex!.isVideoLiked) {
                        widget.currentIndex!.isVideoLiked = false;
                        widget.currentIndex!.likeCount =
                            widget.currentIndex!.likeCount - 1;
                        setState(() {});
                      } else {
                        widget.currentIndex!.isVideoLiked = true;
                        widget.currentIndex!.likeCount =
                            widget.currentIndex!.likeCount + 1;
                        setState(() {});
                      }
                    },
                    child: Column(
                      children: [
                        SvgImage(
                            path: heart_icon,
                            height: 30,
                            width: 32,
                            color: widget.currentIndex!.isVideoLiked
                                ? AppColors.acmeBlue
                                : AppColors.pureWhite),
                        SizedBox(height: 2),
                        TextView(
                          widget.currentIndex!.likeCount.toString(),
                          textStyle: TextStyles.semiBoldTextStyle(
                              fontSize: 13, textColor: AppColors.pureWhite),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showCommentBottomSheet(
                        animationController,
                        context,
                        widget.videos[widget.index].video_bots_id,
                        (value) {
                          widget.currentIndex!.commentsCount = value;
                          setState(() {});
                        },
                        widget.currentIndex!.user_image,
                      );
                    },
                    child: SvgImage(
                      path: message_icon,
                      height: 37,
                      width: 40,
                    ),
                  ),
                  TextView(
                    widget.videos[widget.index].commentsCount.toString(),
                    textStyle: TextStyles.semiBoldTextStyle(
                        fontSize: 13, textColor: AppColors.pureWhite),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      Uri url =
                          await DynamicLinks.instance.createDynamicLink(false);
                      share(context, url,
                          widget.videos[widget.index].video_bots_id);
                    },
                    child: SvgImage(path: share_icon, height: 35, width: 38),
                  ),
                  TextView(
                    'Share',
                    textStyle: TextStyles.semiBoldTextStyle(
                        fontSize: 13, textColor: AppColors.pureWhite),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: VideoBotProfileWidget(
              tapOnProfile: () {
                widget.controller!.pause();
                widget.controller = null;
                if (AuthRepo.instance.user.userName ==
                    widget.currentIndex!.user_name) {
                  NavRouter.push(context, ProfileScreen()).then((value) {
                    widget.controller = BetterPlayerListVideoPlayerController()
                      ..setMixWithOthers(true);
                    betterPlayerConfiguration =
                        BetterPlayerConfiguration(autoPlay: true);
                  });
                } else {
                  NavRouter.push(
                          context,
                          OtherUserProfileScreen(
                              userId: widget.currentIndex!.user_id))
                      .then((value) {
                    widget.controller = BetterPlayerListVideoPlayerController()
                      ..setMixWithOthers(true);
                    betterPlayerConfiguration =
                        BetterPlayerConfiguration(autoPlay: true);
                    Appdata.isFollowing[0] = value;
                    isFollowing = Appdata.isFollowing[0];
                    setState(() {});
                  });
                }
              },
              onTap: (value, questionIndex) {},
              videoData: widget.currentIndex!,
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                // if (flickManager.flickVideoManager!.isPlaying) {
                //   widget.flickMultiManager.pause();
                // }
                showCommentBottomSheet(
                  animationController,
                  context,
                  widget.videos[widget.index].video_bots_id,
                  (value) {
                    widget.currentIndex!.commentsCount = value;
                    setState(() {});
                  },
                  widget.currentIndex!.user_image,
                );
              },
              child: Container(
                height: 44,
                padding: EdgeInsets.only(
                  left: 16,
                ),
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                color: AppColors.black.withOpacity(.45),
                child: Text(
                  'Add a comment...',
                  style: TextStyles.regularTextStyle(
                      fontSize: 14, textColor: AppColors.moon),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void share(BuildContext context, Uri url, int videoIndex) {
    String data = '$url?id=$videoIndex';
    // String data = '${url}';
    Share.share(data);
  }

  showCommentBottomSheet(AnimationController controller, BuildContext context,
      int? videoBotId, Function(int) callBack, String userImage) {
    var commentController = TextEditingController();
    int? replyIndex;
    String? replyId;
    FocusNode commentFocusNode = FocusNode();
    BlocProvider.of<CommentBloc>(context).fetchAllComments(videoBotId);
    showModalBottomSheet(
        transitionAnimationController: controller,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height * .8,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 16),
              child: BlocConsumer<CommentBloc, CommentState>(
                  listener: (context, state) {
                if (state is CommentSent) {
                  BotToast.closeAllLoading();
                  BotToast.showText(text: 'Sent');
                  replyIndex = null;
                  commentController.clear();
                }
                if (state is CommentLikedDisliked) {
                  BotToast.closeAllLoading();
                  BotToast.showText(text: state.message);
                }
                if (state is AllCommentsFetched) {
                  callBack(state.comments.length);
                }
                if (state is CommentError) {
                  BotToast.closeAllLoading();
                  BotToast.showText(text: state.error);
                }
              }, builder: (context, state) {
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Comment',
                        style: TextStyles.boldTextStyle(
                            fontSize: 18, textColor: AppColors.black),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: (state is AllCommentsFetched)
                            ? state.comments.isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    reverse: true,
                                    itemCount: state.comments.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: CommentTreeWidget<CommentModel,
                                            CommentModel>(
                                          state.comments[index],
                                          state.comments[index].reply,
                                          treeThemeData: TreeThemeData(
                                              lineColor: AppColors.silver,
                                              lineWidth: 2),
                                          avatarRoot: (context, data) =>
                                              PreferredSize(
                                            preferredSize: Size.fromRadius(18),
                                            child: userImage.isEmpty
                                                ? CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    backgroundImage: AssetImage(
                                                        ic_user_profile),
                                                  )
                                                : CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(
                                                            '$VIDEO_BASE_URL$userImage'),
                                                  ),
                                          ),
                                          avatarChild: (context, data) =>
                                              PreferredSize(
                                            preferredSize: Size.fromRadius(12),
                                            child: CircleAvatar(
                                              radius: 12,
                                              backgroundColor: AppColors.snow,
                                              backgroundImage:
                                                  AssetImage(ic_user_profile),
                                            ),
                                          ),
                                          contentChild: (context, data) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.snow,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data.user.userName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        data.comment,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                DefaultTextStyle(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                          color:
                                                              Colors.grey[700],
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 4),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        GestureDetector(
                                                          behavior:
                                                              HitTestBehavior
                                                                  .opaque,
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    CommentBloc>()
                                                                .videoLikeDislikeComment(
                                                                    data.id,
                                                                    index,
                                                                    false);
                                                          },
                                                          child: Text(
                                                            'Like',
                                                            style: TextStyle(
                                                                color: data
                                                                        .isLiked
                                                                    ? AppColors
                                                                        .acmeBlue
                                                                    : AppColors
                                                                        .nickel),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 24,
                                                        ),
                                                        GestureDetector(
                                                            behavior:
                                                                HitTestBehavior
                                                                    .opaque,
                                                            onTap: () {
                                                              setState(() {
                                                                if (replyIndex ==
                                                                    index) {
                                                                  if (commentFocusNode
                                                                      .hasFocus) {
                                                                    commentFocusNode
                                                                        .unfocus();
                                                                  }
                                                                  replyIndex =
                                                                      null;
                                                                } else {
                                                                  if (commentFocusNode
                                                                      .hasFocus) {
                                                                    commentFocusNode
                                                                        .unfocus();
                                                                  } else {
                                                                    commentFocusNode
                                                                        .requestFocus();
                                                                  }
                                                                  replyIndex =
                                                                      index;
                                                                  replyId =
                                                                      data.id;
                                                                }
                                                              });
                                                            },
                                                            child: Text('Reply',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .nickel))),
                                                        SizedBox(
                                                          width: 24,
                                                        ),
                                                        if (data.userLikedCount >
                                                            0)
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${data.userLikedCount}',
                                                                style: TextStyles
                                                                    .regularTextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        textColor:
                                                                            AppColors.acmeBlue),
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(4),
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .acmeBlue,
                                                                    shape: BoxShape
                                                                        .circle),
                                                                child: Icon(
                                                                  Icons
                                                                      .thumb_up,
                                                                  size: 10,
                                                                  color: AppColors
                                                                      .pureWhite,
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                          contentRoot: (context, data) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                      color: replyIndex == index
                                                          ? AppColors.moon
                                                          : AppColors.snow,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data.user.userName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption!
                                                            .copyWith(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        data.comment,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption!
                                                            .copyWith(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                DefaultTextStyle(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                          color:
                                                              Colors.grey[700],
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 4),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        GestureDetector(
                                                            behavior:
                                                                HitTestBehavior
                                                                    .opaque,
                                                            onTap: () {
                                                              context
                                                                  .read<
                                                                      CommentBloc>()
                                                                  .videoLikeDislikeComment(
                                                                      data.id,
                                                                      index,
                                                                      true);
                                                            },
                                                            child: Text(
                                                              'Like',
                                                              style: TextStyle(
                                                                  color: data
                                                                          .isLiked
                                                                      ? AppColors
                                                                          .acmeBlue
                                                                      : AppColors
                                                                          .nickel),
                                                            )),
                                                        SizedBox(
                                                          width: 24,
                                                        ),
                                                        GestureDetector(
                                                            behavior:
                                                                HitTestBehavior
                                                                    .opaque,
                                                            onTap: () {
                                                              setState(() {
                                                                if (replyIndex ==
                                                                    index) {
                                                                  if (commentFocusNode
                                                                      .hasFocus) {
                                                                    commentFocusNode
                                                                        .unfocus();
                                                                  }
                                                                  replyIndex =
                                                                      null;
                                                                } else {
                                                                  if (commentFocusNode
                                                                      .hasFocus) {
                                                                    commentFocusNode
                                                                        .unfocus();
                                                                  } else {
                                                                    commentFocusNode
                                                                        .requestFocus();
                                                                  }
                                                                  replyIndex =
                                                                      index;
                                                                  replyId =
                                                                      data.id;
                                                                }
                                                              });
                                                            },
                                                            child: Text(
                                                              'Reply',
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .nickel),
                                                            )),
                                                        SizedBox(
                                                          width: 24,
                                                        ),
                                                        if (data.userLikedCount >
                                                            0)
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${data.userLikedCount}',
                                                                style: TextStyles
                                                                    .regularTextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        textColor:
                                                                            AppColors.acmeBlue),
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(4),
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .acmeBlue,
                                                                    shape: BoxShape
                                                                        .circle),
                                                                child: Icon(
                                                                  Icons
                                                                      .thumb_up,
                                                                  size: 10,
                                                                  color: AppColors
                                                                      .pureWhite,
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text('No Comment yet.'),
                                  )
                            : Center(child: CircularProgressIndicator()),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child:
                            StatefulBuilder(builder: (context, stateBuilder) {
                          return CommentTextField(
                            onTap: () {},
                            focusNode: commentFocusNode,
                            hintText: 'Comment text...',
                            controller: commentController,
                            onChanged: (value) {
                              stateBuilder(() {});
                            },
                            onIconTap: () {
                              if (commentController.text.isNotEmpty) {
                                if (replyIndex == null) {
                                  context
                                      .read<CommentBloc>()
                                      .videoCreateComment(
                                          commentController.text, videoBotId);
                                } else {
                                  context.read<CommentBloc>().videoReplyComment(
                                      commentController.text,
                                      videoBotId,
                                      int.parse(replyId!),
                                      replyIndex!);
                                }
                              } else {
                                BotToast.closeAllLoading();
                                BotToast.showText(
                                    text: 'Comment should not be empty');
                              }
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                );
              }));
        }).then((value) {
      print("Bottom Sheet Disappear");
      // widget.flickMultiManager.play(flickManager);
    });
  }
}
