import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/core/services/dynamic_links/dynamic_links.dart';
import 'package:helpert_app/features/new_video_upload/screens/flick_media_player_docs/reuseable_video_list_controller.dart';
import 'package:share/share.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../common_widgets/components/text_view.dart';
import '../../../../constants/api_endpoints.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/text_styles.dart';
import '../../../../utils/nav_router.dart';
import '../../../auth/repo/auth_repo.dart';
import '../../../other_user_profile/screens/other_profile_screen.dart';
import '../../../profile/profile_screen.dart';
import '../../../reusable_video_list/app_data.dart';
import '../../../video/bloc/comment/comment_bloc.dart';
import '../../../video/bloc/comment/comment_state.dart';
import '../../../video/model/comment_model.dart';
import '../../../video/model/videos_model.dart';
import '../../../video/videobots/widgets/videobot_profile_widget.dart';
import '../../../video/videobots/widgets/videobot_topbar.dart';
import '../../../video/widget/comment_textfield.dart';
import '../../../video/widget/comment_tree_widget.dart';
import '../../../video/widget/tree_theme_data.dart';
import '../../bloc/fetch_user_video_bloc.dart';

class FlickMultiPlayer extends StatefulWidget {
  const FlickMultiPlayer({
    Key? key,
    required this.url,
    this.currentIndex,
    required this.listIndex,
    required this.videoViews,
    required this.index,
    required this.videoList,
    required this.videoListController,
    this.canBuildVideo,
  }) : super(key: key);
  final VideoBotModel? currentIndex;
  final int listIndex;
  final ReusableVideoListController videoListController;
  final String url;
  final int videoViews;
  final Function? canBuildVideo;
  final int index;
  final List<VideoBotModel> videoList;
  // final String? image;

  @override
  _FlickMultiPlayerState createState() => _FlickMultiPlayerState();
}

class _FlickMultiPlayerState extends State<FlickMultiPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller2;

  // better player
  List<VideoBotModel> get videoListData => widget.videoList;

  BetterPlayerController? controller;
  StreamController<BetterPlayerController?>
      betterPlayerControllerStreamController = StreamController.broadcast();
  bool _initialized = false;
  Timer? _timer;

  void _setupController() {
    if (controller == null) {
      controller = widget.videoListController.getBetterPlayerController();
      if (controller != null) {
        controller!.setupDataSource(BetterPlayerDataSource.network(
            '$VIDEO_BASE_URL${widget.videoList[widget.index].video}',
            cacheConfiguration:
                BetterPlayerCacheConfiguration(useCache: true)));
        if (!betterPlayerControllerStreamController.isClosed) {
          betterPlayerControllerStreamController.add(controller);
        }
        controller!.addEventsListener(onPlayerEvent);
        debugPrint('$VIDEO_BASE_URL${widget.videoList[widget.index].video}');
      }
    }
  }

  void _freeController() {
    if (!_initialized) {
      _initialized = true;
      return;
    }
    if (controller != null && _initialized) {
      controller!.removeEventsListener(onPlayerEvent);
      widget.videoListController.freeBetterPlayerController(controller);
      controller!.pause();
      controller = null;
      if (!betterPlayerControllerStreamController.isClosed) {
        betterPlayerControllerStreamController.add(null);
      }
      _initialized = false;
    }
  }

  void onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
      widget.videoList[widget.index].lastPosition =
          event.parameters!["progress"] as Duration?;
    }
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      if (widget.videoList[widget.index].lastPosition != null) {
        controller!.seekTo(widget.videoList[widget.index].lastPosition!);
      }
      if (widget.videoList[widget.index].wasPlaying == true) {
        controller!.play();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller2 = BottomSheet.createAnimationController(this);
    controller2.duration = const Duration(milliseconds: 400);
  }

  @override
  void dispose() {
    betterPlayerControllerStreamController.close();
    super.dispose();
  }

  int totalLikes = -1;
  bool? isVideoLiked;
  int isFollowing = 0;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(hashCode.toString() + DateTime.now().toString()),
      onVisibilityChanged: (info) {
        if (!widget.canBuildVideo!()) {
          _timer?.cancel();
          _timer = null;
          _timer = Timer(Duration(milliseconds: 500), () {
            if (info.visibleFraction >= 0.6) {
              _setupController();
            } else {
              _freeController();
            }
          });
          return;
        }
        if (info.visibleFraction >= 0.6) {
          _setupController();
        } else {
          _freeController();
        }
      },
      child: Stack(
        children: [
          StreamBuilder<BetterPlayerController?>(
            stream: betterPlayerControllerStreamController.stream,
            builder: (context, snapshot) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: controller != null
                    ? BetterPlayer(
                        controller: controller!,
                      )
                    : Container(
                        color: Colors.black,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
              );
            },
          ),
          VideoBotTopBar(
              isFollowing: isFollowing,
              videoViews: widget.videoViews,
              currentIndex: widget.currentIndex),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<FetchUserVideoBloc>().videoLikeDislike(
                          widget.currentIndex!.video_bots_id,
                          widget.index,
                          widget.videoList);
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
                            height: 22,
                            width: 24,
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
                        controller2,
                        context,
                        widget.videoList[widget.index].video_bots_id,
                        (value) {
                          widget.currentIndex!.commentsCount = value;
                          setState(() {});
                        },
                        widget.currentIndex!.user_image,
                      );
                    },
                    child: SvgImage(
                      path: message_icon,
                      height: 22,
                      width: 24,
                      color: AppColors.pureWhite,
                    ),
                  ),
                  TextView(
                    widget.videoList[widget.index].commentsCount.toString(),
                    textStyle: TextStyles.semiBoldTextStyle(
                        fontSize: 13, textColor: AppColors.pureWhite),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      Uri url =
                          await DynamicLinks.instance.createDynamicLink(false);
                      share(context, url,
                          widget.videoList[widget.index].video_bots_id);
                    },
                    child: SvgImage(
                      path: share_icon,
                      height: 22,
                      width: 24,
                    ),
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
                if (AuthRepo.instance.user.userName ==
                    widget.currentIndex!.user_name) {
                  NavRouter.push(context, ProfileScreen());
                } else {
                  NavRouter.push(
                          context,
                          OtherUserProfileScreen(
                              userId: widget.currentIndex!.user_id))
                      .then((value) {
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
                  controller2,
                  context,
                  widget.videoList[widget.index].video_bots_id,
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

  @override
  void deactivate() {
    if (controller != null) {
      widget.videoList[widget.index].wasPlaying = controller!.isPlaying();
    }
    _initialized = true;
    super.deactivate();
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
                                            preferredSize: Size.fromRadius(18),
                                          ),
                                          avatarChild: (context, data) =>
                                              PreferredSize(
                                            child: CircleAvatar(
                                              radius: 12,
                                              backgroundColor: AppColors.snow,
                                              backgroundImage:
                                                  AssetImage(ic_user_profile),
                                            ),
                                            preferredSize: Size.fromRadius(12),
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
      debugPrint("Bottom Sheet Disappear");
      // widget.flickMultiManager.play(flickManager);
    });
  }
}
