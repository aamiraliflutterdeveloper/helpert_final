import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/components/text_view.dart';
import 'package:helpert_app/features/video/bloc/comment/comment_bloc.dart';
import 'package:helpert_app/features/video/bloc/comment/comment_state.dart';
import 'package:helpert_app/features/video/model/comment_model.dart';
import 'package:helpert_app/features/video/model/videos_model.dart';
import 'package:helpert_app/features/video/widget/comment_textfield.dart';
import 'package:helpert_app/features/video/widget/comment_tree_widget.dart';
import 'package:helpert_app/features/video/widget/tree_theme_data.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/text_styles.dart';

class VideoBotScreen extends StatefulWidget {
  final String route;
  final int listIndex;
  final List<VideoBotModel> videoList;
  const VideoBotScreen(
      {Key? key,
      required this.videoList,
      required this.listIndex,
      required this.route})
      : super(key: key);

  @override
  State<VideoBotScreen> createState() => _VideoBotScreenState();
}

class _VideoBotScreenState extends State<VideoBotScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  bool finishedPlaying = false;
  bool playList = true;
  bool isDefaultVideo = false;
  bool hideCommentSection = false;
  int videoIndex = -1;
  VideoBotModel? currentIndex;
  List playingQuestionIndex = [];
  List<String> videosList = [];
  late PageController pageController =
      PageController(initialPage: widget.listIndex);

  late AnimationController controller;

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.vertical,
        itemCount: widget.videoList.length,
        onPageChanged: (index) {
          playList = true;
          videoIndex = -1;
          hideCommentSection = false;
        },
        itemBuilder: (context, index) {
          currentIndex = widget.videoList[index];
          return Stack(
            children: [
              // VideoBotTopBar(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(heart_icon),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {},
                        child: TextView(
                          '328.7k',
                          textStyle: TextStyles.semiBoldTextStyle(
                              fontSize: 16, textColor: AppColors.pureWhite),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: Image.asset(message_icon),
                      ),
                      TextView(
                        '578',
                        textStyle: TextStyles.semiBoldTextStyle(
                            fontSize: 16, textColor: AppColors.pureWhite),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(share_icon),
                      ),
                      TextView(
                        'Share',
                        textStyle: TextStyles.semiBoldTextStyle(
                            fontSize: 16, textColor: AppColors.pureWhite),
                      ),
                    ],
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: VideoBotProfileWidget(
              //     onTap: (value, questionIndex) {},
              //     videoData: currentIndex!,
              //   ),
              // ),
              Positioned(
                bottom: 0,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {},
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
              )
            ],
          );
        },
      ),
    );
  }

  showCommentBottomSheet(
      AnimationController controller,
      BuildContext context,
      int? videoBotId,
      int? questionId,
      Function(int) callBack,
      String userImage) {
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
                                                            userImage),
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
                                        commentController.text,
                                        videoBotId,
                                        // questionId,
                                      );
                                } else {
                                  context.read<CommentBloc>().videoReplyComment(
                                      commentController.text,
                                      videoBotId,
                                      // questionId,
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
        });
  }
}
