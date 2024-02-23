// import 'package:better_player/better_player.dart';
// import 'package:bot_toast/bot_toast.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:share/share.dart';
//
// import '../../../common_widgets/components/text_view.dart';
// import '../../../common_widgets/fetch_svg.dart';
// import '../../../constants/api_endpoints.dart';
// import '../../../constants/app_colors.dart';
// import '../../../constants/asset_paths.dart';
// import '../../../constants/text_styles.dart';
// import '../../../core/services/dynamic_links/dynamic_links.dart';
// import '../../../utils/nav_router.dart';
// import '../../auth/repo/auth_repo.dart';
// import '../../other_user_profile/screens/other_profile_screen.dart';
// import '../../profile/profile_screen.dart';
// import '../../reusable_video_list/app_data.dart';
// import '../../video/bloc/comment/comment_bloc.dart';
// import '../../video/bloc/comment/comment_state.dart';
// import '../../video/model/comment_model.dart';
// import '../../video/model/videos_model.dart';
// import '../../video/videobots/widgets/videobot_profile_widget.dart';
// import '../../video/videobots/widgets/videobot_topbar.dart';
// import '../../video/widget/comment_textfield.dart';
// import '../../video/widget/comment_tree_widget.dart';
// import '../../video/widget/tree_theme_data.dart';
// import '../bloc/fetch_user_video_bloc.dart';
// import '../bloc/video_view_bloc.dart';
//
// class VideoListWidget extends StatefulWidget {
//   final List<VideoBotModel> videoList;
//   int listIndex;
//   int? videoBotId;
//   VideoListWidget({Key? key, required this.videoList, required this.listIndex})
//       : super(key: key);
//
//   @override
//   VideoListWidgetState createState() => VideoListWidgetState();
// }
//
// class VideoListWidgetState extends State<VideoListWidget>
//     with SingleTickerProviderStateMixin {
//   List items = [];
//   BetterPlayerListVideoPlayerController? betterController;
//   late AnimationController controller;
//   @override
//   void initState() {
//     super.initState();
//     if (widget.videoBotId != null) {
//       widget.listIndex = widget.videoList.indexOf(widget.videoList
//           .where((element) => element.video_bots_id == widget.videoBotId)
//           .first);
//     }
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       getVideoViews();
//     });
//     betterController = BetterPlayerListVideoPlayerController();
//     controller = BottomSheet.createAnimationController(this);
//     controller.duration = const Duration(milliseconds: 400);
//     // controller!.seekTo(Duration(seconds: 0));
//   }
//
//   int currentVideoBotID = -1;
//   int videoViews = 0;
//
//   getVideoViews() {
//     if (mounted && widget.videoList[currentVideoBotID].is_video_view == false) {
//       context.read<VideoViewBloc>().videoView(
//           videoBotId: widget.videoList[currentVideoBotID].video_bots_id,
//           videoQuestionId: null);
//     }
//     videoViews = widget.videoList[currentVideoBotID].video_view_count;
//     if (widget.videoList[currentVideoBotID].is_video_view == false) {
//       videoViews += 1;
//       setState(() {});
//     }
//     setState(() {});
//   }
//
//   VideoBotModel? currentIndex;
//   late PageController pageController =
//       PageController(initialPage: widget.listIndex);
//
//   int totalLikes = -1;
//   bool? isVideoLiked;
//   int isFollowing = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView.builder(
//         controller: pageController,
//         scrollDirection: Axis.vertical,
//         itemCount: widget.videoList.length,
//         onPageChanged: (val) {
//           getVideoViews();
//           setState(() {});
//         },
//         itemBuilder: (context, index) {
//           currentVideoBotID = index;
//           currentIndex = widget.videoList[index];
//           return Stack(
//             children: [
//               BetterPlayerListVideoPlayer(
//                 BetterPlayerDataSource(
//                   BetterPlayerDataSourceType.network,
//                   widget.videoList[index].video,
//                   bufferingConfiguration: BetterPlayerBufferingConfiguration(
//                       minBufferMs: 2000,
//                       maxBufferMs: 10000,
//                       bufferForPlaybackMs: 1000,
//                       bufferForPlaybackAfterRebufferMs: 2000),
//                 ),
//                 configuration: BetterPlayerConfiguration(
//                   autoDetectFullscreenAspectRatio: true,
//                   expandToFill: true,
//                   autoPlay: true,
//                   handleLifecycle: true,
//                   looping: true,
//                   translations: [],
//                   aspectRatio: .48,
//                   fit: BoxFit.cover,
//                   placeholderOnTop: false,
//                   controlsConfiguration: BetterPlayerControlsConfiguration(
//                     enableRetry: true,
//                     enablePip: false,
//                     enableOverflowMenu: false,
//                     enableFullscreen: false,
//                     enableMute: false,
//                     enableProgressText: false,
//                     enableProgressBar: false,
//                     enableProgressBarDrag: false,
//                     enablePlayPause: false,
//                     enableSkips: false,
//                     enableAudioTracks: false,
//                     enableSubtitles: false,
//                     enableQualities: false,
//                     enablePlaybackSpeed: false,
//                   ),
//                 ),
//                 playFraction: 0.8,
//                 betterPlayerListVideoPlayerController: betterController,
//               ),
//               VideoBotTopBar(
//                   isFollowing: isFollowing,
//                   videoViews: videoViews,
//                   currentIndex: currentIndex),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           context.read<FetchUserVideoBloc>().videoLikeDislike(
//                               currentIndex!.video_bots_id,
//                               index,
//                               widget.videoList);
//                           if (currentIndex!.isVideoLiked) {
//                             currentIndex!.isVideoLiked = false;
//                             currentIndex!.likeCount =
//                                 currentIndex!.likeCount - 1;
//                             setState(() {});
//                           } else {
//                             currentIndex!.isVideoLiked = true;
//                             currentIndex!.likeCount =
//                                 currentIndex!.likeCount + 1;
//                             setState(() {});
//                           }
//                         },
//                         child: Column(
//                           children: [
//                             SvgImage(
//                                 path: heart_icon,
//                                 height: 32,
//                                 width: 35,
//                                 color: currentIndex!.isVideoLiked
//                                     ? AppColors.acmeBlue
//                                     : AppColors.pureWhite),
//                             SizedBox(height: 2),
//                             TextView(
//                               currentIndex!.likeCount.toString(),
//                               textStyle: TextStyles.semiBoldTextStyle(
//                                   fontSize: 13, textColor: AppColors.pureWhite),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       GestureDetector(
//                         behavior: HitTestBehavior.opaque,
//                         onTap: () {
//                           showCommentBottomSheet(
//                             controller,
//                             context,
//                             widget.videoList[index].video_bots_id,
//                             (value) {
//                               currentIndex!.commentsCount = value;
//                               setState(() {});
//                             },
//                             currentIndex!.user_image,
//                           );
//                         },
//                         child: SvgImage(
//                           path: message_icon,
//                           height: 33,
//                           width: 35,
//                         ),
//                       ),
//                       TextView(
//                         widget.videoList[index].commentsCount.toString(),
//                         textStyle: TextStyles.semiBoldTextStyle(
//                             fontSize: 13, textColor: AppColors.pureWhite),
//                       ),
//                       SizedBox(height: 20),
//                       GestureDetector(
//                         onTap: () async {
//                           Uri url = await DynamicLinks.instance
//                               .createDynamicLink(false);
//                           share(context, url,
//                               widget.videoList[index].video_bots_id);
//                         },
//                         child: SvgImage(
//                           path: share_icon,
//                           height: 26,
//                           width: 34,
//                         ),
//                       ),
//                       TextView(
//                         'Share',
//                         textStyle: TextStyles.semiBoldTextStyle(
//                             fontSize: 13, textColor: AppColors.pureWhite),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: VideoBotProfileWidget(
//                   tapOnProfile: () {
//                     if (AuthRepo.instance.user.userName ==
//                         currentIndex!.user_name) {
//                       NavRouter.push(context, ProfileScreen());
//                     } else {
//                       NavRouter.push(
//                               context,
//                               OtherUserProfileScreen(
//                                   userId: currentIndex!.user_id))
//                           .then((value) {
//                         Appdata.isFollowing[0] = value;
//                         isFollowing = Appdata.isFollowing[0];
//                         setState(() {});
//                       });
//                     }
//                   },
//                   onTap: (value, questionIndex) {},
//                   videoData: currentIndex!,
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 child: GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () async {
//                     // if (flickManager.flickVideoManager!.isPlaying) {
//                     //   widget.flickMultiManager.pause();
//                     // }
//                     showCommentBottomSheet(
//                       controller,
//                       context,
//                       widget.videoList[index].video_bots_id,
//                       (value) {
//                         currentIndex!.commentsCount = value;
//                         setState(() {});
//                       },
//                       currentIndex!.user_image,
//                     );
//                   },
//                   child: Container(
//                     height: 44,
//                     padding: EdgeInsets.only(
//                       left: 16,
//                     ),
//                     alignment: Alignment.centerLeft,
//                     width: MediaQuery.of(context).size.width,
//                     color: AppColors.black.withOpacity(.45),
//                     child: Text(
//                       'Add a comment...',
//                       style: TextStyles.regularTextStyle(
//                           fontSize: 14, textColor: AppColors.moon),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//           // return SizedBox(
//           //     height: MediaQuery.of(context).size.height,
//           //     child: FlickMultiPlayer(
//           //       videoList: widget.videoList,
//           //       index: index,
//           //       videoViews: videoViews,
//           //       listIndex: widget.listIndex,
//           //       // url: videosList[index],
//           //       url: widget.videoList[index].video,
//           //       // url: items[index],
//           //       flickMultiManager: flickMultiManager,
//           //       currentIndex: currentIndex,
//           //       // image: shortVideoMockData['items'][index]['image'],
//           //     ));
//         },
//       ),
//     );
//   }
//
//   void share(BuildContext context, Uri url, int videoIndex) {
//     String data = '$url?id=$videoIndex';
//     // String data = '${url}';
//     Share.share(data);
//   }
//
//   showCommentBottomSheet(AnimationController controller, BuildContext context,
//       int? videoBotId, Function(int) callBack, String userImage) {
//     var commentController = TextEditingController();
//     int? replyIndex;
//     String? replyId;
//     FocusNode commentFocusNode = FocusNode();
//     BlocProvider.of<CommentBloc>(context).fetchAllComments(videoBotId);
//     showModalBottomSheet(
//         transitionAnimationController: controller,
//         backgroundColor: Colors.transparent,
//         barrierColor: Colors.transparent,
//         isScrollControlled: true,
//         context: context,
//         builder: (context) {
//           return Container(
//               height: MediaQuery.of(context).size.height * .8,
//               alignment: Alignment.bottomCenter,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20))),
//               padding: const EdgeInsets.only(
//                   left: 16, right: 16, top: 8, bottom: 16),
//               child: BlocConsumer<CommentBloc, CommentState>(
//                   listener: (context, state) {
//                 if (state is CommentSent) {
//                   BotToast.closeAllLoading();
//                   BotToast.showText(text: 'Sent');
//                   replyIndex = null;
//                   commentController.clear();
//                 }
//                 if (state is CommentLikedDisliked) {
//                   BotToast.closeAllLoading();
//                   BotToast.showText(text: state.message);
//                 }
//                 if (state is AllCommentsFetched) {
//                   callBack(state.comments.length);
//                 }
//                 if (state is CommentError) {
//                   BotToast.closeAllLoading();
//                   BotToast.showText(text: state.error);
//                 }
//               }, builder: (context, state) {
//                 return Scaffold(
//                   resizeToAvoidBottomInset: true,
//                   backgroundColor: Colors.transparent,
//                   body: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       SizedBox(
//                         height: 16,
//                       ),
//                       Text(
//                         'Comment',
//                         style: TextStyles.boldTextStyle(
//                             fontSize: 18, textColor: AppColors.black),
//                       ),
//                       SizedBox(
//                         height: 16,
//                       ),
//                       Expanded(
//                         child: (state is AllCommentsFetched)
//                             ? state.comments.isNotEmpty
//                                 ? ListView.builder(
//                                     padding: EdgeInsets.symmetric(vertical: 20),
//                                     reverse: true,
//                                     itemCount: state.comments.length,
//                                     itemBuilder: (context, index) {
//                                       return Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 12, horizontal: 16),
//                                         child: CommentTreeWidget<CommentModel,
//                                             CommentModel>(
//                                           state.comments[index],
//                                           state.comments[index].reply,
//                                           treeThemeData: TreeThemeData(
//                                               lineColor: AppColors.silver,
//                                               lineWidth: 2),
//                                           avatarRoot: (context, data) =>
//                                               PreferredSize(
//                                             child: userImage.isEmpty
//                                                 ? CircleAvatar(
//                                                     radius: 18,
//                                                     backgroundColor:
//                                                         Colors.grey,
//                                                     backgroundImage: AssetImage(
//                                                         ic_user_profile),
//                                                   )
//                                                 : CircleAvatar(
//                                                     radius: 18,
//                                                     backgroundColor:
//                                                         Colors.grey,
//                                                     backgroundImage:
//                                                         CachedNetworkImageProvider(
//                                                             '$VIDEO_BASE_URL$userImage'),
//                                                   ),
//                                             preferredSize: Size.fromRadius(18),
//                                           ),
//                                           avatarChild: (context, data) =>
//                                               PreferredSize(
//                                             child: CircleAvatar(
//                                               radius: 12,
//                                               backgroundColor: AppColors.snow,
//                                               backgroundImage:
//                                                   AssetImage(ic_user_profile),
//                                             ),
//                                             preferredSize: Size.fromRadius(12),
//                                           ),
//                                           contentChild: (context, data) {
//                                             return Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 8,
//                                                       horizontal: 8),
//                                                   decoration: BoxDecoration(
//                                                       color: AppColors.snow,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               12)),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         data.user.userName,
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .caption
//                                                             ?.copyWith(
//                                                                 fontSize: 14,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600,
//                                                                 color: Colors
//                                                                     .black),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 4,
//                                                       ),
//                                                       Text(
//                                                         data.comment,
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .caption
//                                                             ?.copyWith(
//                                                                 fontSize: 14,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w300,
//                                                                 color: Colors
//                                                                     .black),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 DefaultTextStyle(
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .caption!
//                                                       .copyWith(
//                                                           color:
//                                                               Colors.grey[700],
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                   child: Padding(
//                                                     padding:
//                                                         EdgeInsets.only(top: 4),
//                                                     child: Row(
//                                                       children: [
//                                                         SizedBox(
//                                                           width: 8,
//                                                         ),
//                                                         GestureDetector(
//                                                           behavior:
//                                                               HitTestBehavior
//                                                                   .opaque,
//                                                           onTap: () {
//                                                             context
//                                                                 .read<
//                                                                     CommentBloc>()
//                                                                 .videoLikeDislikeComment(
//                                                                     data.id,
//                                                                     index,
//                                                                     false);
//                                                           },
//                                                           child: Text(
//                                                             'Like',
//                                                             style: TextStyle(
//                                                                 color: data
//                                                                         .isLiked
//                                                                     ? AppColors
//                                                                         .acmeBlue
//                                                                     : AppColors
//                                                                         .nickel),
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           width: 24,
//                                                         ),
//                                                         GestureDetector(
//                                                             behavior:
//                                                                 HitTestBehavior
//                                                                     .opaque,
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 if (replyIndex ==
//                                                                     index) {
//                                                                   if (commentFocusNode
//                                                                       .hasFocus) {
//                                                                     commentFocusNode
//                                                                         .unfocus();
//                                                                   }
//                                                                   replyIndex =
//                                                                       null;
//                                                                 } else {
//                                                                   if (commentFocusNode
//                                                                       .hasFocus) {
//                                                                     commentFocusNode
//                                                                         .unfocus();
//                                                                   } else {
//                                                                     commentFocusNode
//                                                                         .requestFocus();
//                                                                   }
//                                                                   replyIndex =
//                                                                       index;
//                                                                   replyId =
//                                                                       data.id;
//                                                                 }
//                                                               });
//                                                             },
//                                                             child: Text('Reply',
//                                                                 style: TextStyle(
//                                                                     color: AppColors
//                                                                         .nickel))),
//                                                         SizedBox(
//                                                           width: 24,
//                                                         ),
//                                                         if (data.userLikedCount >
//                                                             0)
//                                                           Row(
//                                                             children: [
//                                                               Text(
//                                                                 '${data.userLikedCount}',
//                                                                 style: TextStyles
//                                                                     .regularTextStyle(
//                                                                         fontSize:
//                                                                             10,
//                                                                         textColor:
//                                                                             AppColors.acmeBlue),
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 4,
//                                                               ),
//                                                               Container(
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .all(4),
//                                                                 decoration: BoxDecoration(
//                                                                     color: AppColors
//                                                                         .acmeBlue,
//                                                                     shape: BoxShape
//                                                                         .circle),
//                                                                 child: Icon(
//                                                                   Icons
//                                                                       .thumb_up,
//                                                                   size: 10,
//                                                                   color: AppColors
//                                                                       .pureWhite,
//                                                                 ),
//                                                               )
//                                                             ],
//                                                           )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             );
//                                           },
//                                           contentRoot: (context, data) {
//                                             return Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 8,
//                                                       horizontal: 8),
//                                                   decoration: BoxDecoration(
//                                                       color: replyIndex == index
//                                                           ? AppColors.moon
//                                                           : AppColors.snow,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               12)),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         data.user.userName,
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .caption!
//                                                             .copyWith(
//                                                                 fontSize: 16,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600,
//                                                                 color: Colors
//                                                                     .black),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 4,
//                                                       ),
//                                                       Text(
//                                                         data.comment,
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .caption!
//                                                             .copyWith(
//                                                                 fontSize: 16,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w300,
//                                                                 color: Colors
//                                                                     .black),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 DefaultTextStyle(
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .caption!
//                                                       .copyWith(
//                                                           color:
//                                                               Colors.grey[700],
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                   child: Padding(
//                                                     padding:
//                                                         EdgeInsets.only(top: 4),
//                                                     child: Row(
//                                                       children: [
//                                                         SizedBox(
//                                                           width: 8,
//                                                         ),
//                                                         GestureDetector(
//                                                             behavior:
//                                                                 HitTestBehavior
//                                                                     .opaque,
//                                                             onTap: () {
//                                                               context
//                                                                   .read<
//                                                                       CommentBloc>()
//                                                                   .videoLikeDislikeComment(
//                                                                       data.id,
//                                                                       index,
//                                                                       true);
//                                                             },
//                                                             child: Text(
//                                                               'Like',
//                                                               style: TextStyle(
//                                                                   color: data
//                                                                           .isLiked
//                                                                       ? AppColors
//                                                                           .acmeBlue
//                                                                       : AppColors
//                                                                           .nickel),
//                                                             )),
//                                                         SizedBox(
//                                                           width: 24,
//                                                         ),
//                                                         GestureDetector(
//                                                             behavior:
//                                                                 HitTestBehavior
//                                                                     .opaque,
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 if (replyIndex ==
//                                                                     index) {
//                                                                   if (commentFocusNode
//                                                                       .hasFocus) {
//                                                                     commentFocusNode
//                                                                         .unfocus();
//                                                                   }
//                                                                   replyIndex =
//                                                                       null;
//                                                                 } else {
//                                                                   if (commentFocusNode
//                                                                       .hasFocus) {
//                                                                     commentFocusNode
//                                                                         .unfocus();
//                                                                   } else {
//                                                                     commentFocusNode
//                                                                         .requestFocus();
//                                                                   }
//                                                                   replyIndex =
//                                                                       index;
//                                                                   replyId =
//                                                                       data.id;
//                                                                 }
//                                                               });
//                                                             },
//                                                             child: Text(
//                                                               'Reply',
//                                                               style: TextStyle(
//                                                                   color: AppColors
//                                                                       .nickel),
//                                                             )),
//                                                         SizedBox(
//                                                           width: 24,
//                                                         ),
//                                                         if (data.userLikedCount >
//                                                             0)
//                                                           Row(
//                                                             children: [
//                                                               Text(
//                                                                 '${data.userLikedCount}',
//                                                                 style: TextStyles
//                                                                     .regularTextStyle(
//                                                                         fontSize:
//                                                                             10,
//                                                                         textColor:
//                                                                             AppColors.acmeBlue),
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 4,
//                                                               ),
//                                                               Container(
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .all(4),
//                                                                 decoration: BoxDecoration(
//                                                                     color: AppColors
//                                                                         .acmeBlue,
//                                                                     shape: BoxShape
//                                                                         .circle),
//                                                                 child: Icon(
//                                                                   Icons
//                                                                       .thumb_up,
//                                                                   size: 10,
//                                                                   color: AppColors
//                                                                       .pureWhite,
//                                                                 ),
//                                                               )
//                                                             ],
//                                                           )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             );
//                                           },
//                                         ),
//                                       );
//                                     },
//                                   )
//                                 : Center(
//                                     child: Text('No Comment yet.'),
//                                   )
//                             : Center(child: CircularProgressIndicator()),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(16),
//                         child:
//                             StatefulBuilder(builder: (context, stateBuilder) {
//                           return CommentTextField(
//                             onTap: () {},
//                             focusNode: commentFocusNode,
//                             hintText: 'Comment text...',
//                             controller: commentController,
//                             onChanged: (value) {
//                               stateBuilder(() {});
//                             },
//                             onIconTap: () {
//                               if (commentController.text.isNotEmpty) {
//                                 if (replyIndex == null) {
//                                   context
//                                       .read<CommentBloc>()
//                                       .videoCreateComment(
//                                           commentController.text, videoBotId);
//                                 } else {
//                                   context.read<CommentBloc>().videoReplyComment(
//                                       commentController.text,
//                                       videoBotId,
//                                       int.parse(replyId!),
//                                       replyIndex!);
//                                 }
//                               } else {
//                                 BotToast.closeAllLoading();
//                                 BotToast.showText(
//                                     text: 'Comment should not be empty');
//                               }
//                             },
//                           );
//                         }),
//                       ),
//                     ],
//                   ),
//                 );
//               }));
//         }).then((value) {
//       print("Bottom Sheet Disappear");
//       // widget.flickMultiManager.play(flickManager);
//     });
//   }
// }
