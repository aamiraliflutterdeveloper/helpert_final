import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/video/bloc/comment/comment_bloc.dart';
import 'package:helpert_app/features/video/bloc/comment/comment_state.dart';
import 'package:helpert_app/features/video/model/comment_model.dart';
import 'package:helpert_app/features/video/widget/comment_textfield.dart';
import 'package:helpert_app/features/video/widget/comment_tree_widget.dart';
import 'package:helpert_app/features/video/widget/tree_theme_data.dart';

class CommentScreen extends StatefulWidget {
  final int? questionId;
  final int? videoBotId;
  final Function(int) onCountChange;
  const CommentScreen(
      {Key? key,
      this.questionId,
      required this.videoBotId,
      required this.onCountChange})
      : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  var commentController = TextEditingController();
  String? commentError;
  int? replyIndex;
  String? replyId;
  List<int> moreIndex = [];
  FocusNode commentFocusNode = FocusNode();

  @override
  void initState() {
    // BlocProvider.of<CommentBloc>(context)
    //     .fetchAllComments(widget.videoBotId, widget.questionId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Comments',
      ),
      body: BlocConsumer<CommentBloc, CommentState>(listener: (context, state) {
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
        if (state is CommentError) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.error);
        }
      }, builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: (state is AllCommentsFetched)
                  ? state.comments.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          reverse: true,
                          itemCount: state.comments.length,
                          itemBuilder: (context, index) {
                            widget.onCountChange(state.comments.length);
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child:
                                  CommentTreeWidget<CommentModel, CommentModel>(
                                state.comments[index],
                                state.comments[index].reply,
                                treeThemeData: TreeThemeData(
                                    lineColor: AppColors.silver, lineWidth: 2),
                                avatarRoot: (context, data) => PreferredSize(
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: CachedNetworkImageProvider(
                                        'https://picsum.photos/200/300'),
                                  ),
                                  preferredSize: Size.fromRadius(18),
                                ),
                                avatarChild: (context, data) => PreferredSize(
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: AppColors.snow,
                                    backgroundImage: CachedNetworkImageProvider(
                                        'https://picsum.photos/200/300'),
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
                                            vertical: 8, horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: AppColors.snow,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.user.userName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  ?.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
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
                                                          FontWeight.w300,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DefaultTextStyle(
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 8,
                                              ),
                                              GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () {
                                                  context
                                                      .read<CommentBloc>()
                                                      .videoLikeDislikeComment(
                                                          data.id,
                                                          index,
                                                          false);
                                                },
                                                child: Text(
                                                  'Like',
                                                  style: TextStyle(
                                                      color: data.isLiked
                                                          ? AppColors.acmeBlue
                                                          : AppColors.nickel),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 24,
                                              ),
                                              GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () {
                                                    setState(() {
                                                      if (replyIndex == index) {
                                                        if (commentFocusNode
                                                            .hasFocus) {
                                                          commentFocusNode
                                                              .unfocus();
                                                        }
                                                        replyIndex = null;
                                                      } else {
                                                        if (commentFocusNode
                                                            .hasFocus) {
                                                          commentFocusNode
                                                              .unfocus();
                                                        } else {
                                                          commentFocusNode
                                                              .requestFocus();
                                                        }
                                                        replyIndex = index;
                                                        replyId = data.id;
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
                                              if (data.userLikedCount > 0)
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${data.userLikedCount}',
                                                      style: TextStyles
                                                          .regularTextStyle(
                                                              fontSize: 10,
                                                              textColor:
                                                                  AppColors
                                                                      .acmeBlue),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .acmeBlue,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Icon(
                                                        Icons.thumb_up,
                                                        size: 10,
                                                        color:
                                                            AppColors.pureWhite,
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
                                            vertical: 8, horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: replyIndex == index
                                                ? AppColors.moon
                                                : AppColors.snow,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.user.userName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
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
                                                          FontWeight.w300,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DefaultTextStyle(
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 8,
                                              ),
                                              GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () {
                                                    context
                                                        .read<CommentBloc>()
                                                        .videoLikeDislikeComment(
                                                            data.id,
                                                            index,
                                                            true);
                                                  },
                                                  child: Text(
                                                    'Like',
                                                    style: TextStyle(
                                                        color: data.isLiked
                                                            ? AppColors.acmeBlue
                                                            : AppColors.nickel),
                                                  )),
                                              SizedBox(
                                                width: 24,
                                              ),
                                              GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () {
                                                    setState(() {
                                                      if (replyIndex == index) {
                                                        if (commentFocusNode
                                                            .hasFocus) {
                                                          commentFocusNode
                                                              .unfocus();
                                                        }
                                                        replyIndex = null;
                                                      } else {
                                                        if (commentFocusNode
                                                            .hasFocus) {
                                                          commentFocusNode
                                                              .unfocus();
                                                        } else {
                                                          commentFocusNode
                                                              .requestFocus();
                                                        }
                                                        replyIndex = index;
                                                        replyId = data.id;
                                                      }
                                                    });
                                                  },
                                                  child: Text(
                                                    'Reply',
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.nickel),
                                                  )),
                                              SizedBox(
                                                width: 24,
                                              ),
                                              if (data.userLikedCount > 0)
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${data.userLikedCount}',
                                                      style: TextStyles
                                                          .regularTextStyle(
                                                              fontSize: 10,
                                                              textColor:
                                                                  AppColors
                                                                      .acmeBlue),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .acmeBlue,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Icon(
                                                        Icons.thumb_up,
                                                        size: 10,
                                                        color:
                                                            AppColors.pureWhite,
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

                            //   Container(
                            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            //   margin: EdgeInsets.only(bottom: 16),
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       CircleAvatar(),
                            //       SizedBox(
                            //         width: 16,
                            //       ),
                            //       Expanded(
                            //         child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             Container(
                            //               padding: EdgeInsets.symmetric(
                            //                   vertical: 6, horizontal: 12),
                            //               decoration: BoxDecoration(
                            //                 color: replyIndex != null
                            //                     ? index == replyIndex
                            //                         ? AppColors.moon
                            //                         : AppColors.snow
                            //                     : AppColors.snow,
                            //                 borderRadius: BorderRadius.circular(12),
                            //               ),
                            //               child: Column(
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                 children: [
                            //                   Text(
                            //                     state.comments[index].user.userName,
                            //                     style: TextStyles.semiBoldTextStyle(
                            //                         fontSize: 14),
                            //                   ),
                            //                   Text(
                            //                     state.comments[index].comment,
                            //                     style: TextStyles.regularTextStyle(
                            //                         fontSize: 14),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //             GestureDetector(
                            //               onTap: () {
                            //                 setState(() {
                            //                   if (replyIndex == index) {
                            //                     replyIndex = null;
                            //                   } else {
                            //                     replyIndex = index;
                            //                     replyId = state.comments[index].id;
                            //                   }
                            //                 });
                            //               },
                            //               child: Padding(
                            //                 padding: const EdgeInsets.symmetric(
                            //                     horizontal: 8.0, vertical: 4),
                            //                 child: Text(
                            //                   'Reply',
                            //                   style: TextStyles.regularTextStyle(
                            //                       fontSize: 12,
                            //                       textColor: AppColors.moon),
                            //                 ),
                            //               ),
                            //             ),
                            //             if (state
                            //                     .comments[index].reply.isNotEmpty &&
                            //                 moreIndex.contains(index) == false)
                            //               Padding(
                            //                 padding: const EdgeInsets.symmetric(
                            //                     horizontal: 8.0, vertical: 4),
                            //                 child: Row(
                            //                   children: [
                            //                     CircleAvatar(),
                            //                     Text(
                            //                       state.comments[index].reply[0]
                            //                           .user.userName,
                            //                       style:
                            //                           TextStyles.regularTextStyle(
                            //                               fontSize: 12,
                            //                               textColor:
                            //                                   AppColors.moon),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             if (state.comments[index].reply.length > 1)
                            //               GestureDetector(
                            //                 onTap: () {
                            //                   setState(() {
                            //                     if (moreIndex.contains(index)) {
                            //                       moreIndex.remove(index);
                            //                     } else {
                            //                       moreIndex.add(index);
                            //                     }
                            //                   });
                            //                 },
                            //                 child: Padding(
                            //                   padding: const EdgeInsets.symmetric(
                            //                       horizontal: 8.0, vertical: 4),
                            //                   child: Text(
                            //                     moreIndex.contains(index)
                            //                         ? 'View less...'
                            //                         : 'View all (${state.comments[index].reply.length}) reply',
                            //                     style: TextStyles.boldTextStyle(
                            //                         fontSize: 12,
                            //                         textColor: AppColors.black),
                            //                   ),
                            //                 ),
                            //               ),
                            //             if (state
                            //                     .comments[index].reply.isNotEmpty &&
                            //                 moreIndex.contains(index) == true)
                            //               ListView.builder(
                            //                 shrinkWrap: true,
                            //                 itemCount:
                            //                     state.comments[index].reply.length,
                            //                 itemBuilder: (context, repIndex) {
                            //                   return Row(
                            //                     children: [
                            //                       CircleAvatar(),
                            //                       Text(state.comments[index]
                            //                           .reply[repIndex].comment)
                            //                     ],
                            //                   );
                            //                 },
                            //               ),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // );
                          },
                        )
                      : Center(
                          child: Text('No Comment yet.'),
                        )
                  : Center(child: CircularProgressIndicator()),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: CommentTextField(
                focusNode: commentFocusNode,
                hintText: 'Comment text...',
                controller: commentController,
                onChanged: (value) {
                  setState(() {});
                },
                onIconTap: () {
                  if (commentController.text.isNotEmpty) {
                    if (replyIndex == null) {
                      context.read<CommentBloc>().videoCreateComment(
                            commentController.text,
                            widget.videoBotId,
                            // widget.questionId,
                          );
                    } else {
                      context.read<CommentBloc>().videoReplyComment(
                          commentController.text,
                          widget.videoBotId,
                          // widget.questionId,
                          int.parse(replyId!),
                          replyIndex!);
                    }
                  } else {
                    BotToast.closeAllLoading();
                    BotToast.showText(text: 'Comment should not be empty');
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

// SizedBox(
//   width: 16,
// ),
// ElevatedButton(
//   onPressed: () {
//     if (commentController.text.isNotEmpty) {
//       if (replyIndex == null) {
//         context.read<VideoBloc>().videoCreateComment(
//             commentController.text, 71, 71);
//       } else {
//         context.read<VideoBloc>().videoReplyComment(
//             commentController.text,
//             71,
//             71,
//             int.parse(replyId!),
//             replyIndex!);
//       }
//     } else {
//       BotToast.closeAllLoading();
//       BotToast.showText(text: 'Comment should not be empty');
//     }
//   },
//   style: ElevatedButton.styleFrom(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding:
//           EdgeInsets.symmetric(vertical: 18, horizontal: 8),
//       primary: AppColors.acmeBlue),
//   child: Icon(
//     Icons.send,
//     color: AppColors.pureWhite,
//   ),
// ),
