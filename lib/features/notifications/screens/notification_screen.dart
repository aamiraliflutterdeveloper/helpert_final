import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/features/notifications/bloc/notification_bloc.dart';
import 'package:helpert_app/features/notifications/bloc/notification_state.dart';
import 'package:helpert_app/features/notifications/widgets/notification_image_card.dart';
import 'package:helpert_app/features/other_user_profile/screens/other_profile_screen.dart';

import '../../../common_widgets/components/custom_appbar.dart';
import '../../../utils/nav_router.dart';
import '../../appointment/screens/appointment_detail_screen.dart';
import '../../chat/screens/chat_screen.dart';
import '../../profile/screens/edit_profile_screen.dart';
import '../../video/model/videos_model.dart';
import '../model/notification_model.dart';
import '../widgets/follow_unfollow_card.dart';
import '../widgets/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.wait([
      context.read<NotificationBloc>().updateNotificationCountApi(),
      context.read<NotificationBloc>().fetchNotification(),
    ]);
  }

  List<VideoBotModel> videosList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Notifications',
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
          listener: (context, state) {
        if (state is NotificationError) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.error);
        }
        if (state is NotificationLoaded) {
          BotToast.closeAllLoading();
        }
      }, builder: (context, state) {
        return state is NotificationLoaded
            ? state.notifications.isEmpty
                ? Center(
                    child: Text('No notification found'),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    itemCount: state.notifications.length,
                    itemBuilder: (context, index) {
                      final NotificationModel notificationIndex =
                          state.notifications[index];
                      if (notificationIndex.type == 'newfollow') {
                        return CommonTile(
                            firstName: notificationIndex.firstName,
                            lastName: notificationIndex.lastName,
                            image: notificationIndex.image,
                            callBack: () {
                              if (state.notifications[index].read == 0) {
                                context
                                    .read<NotificationBloc>()
                                    .readNotification(state
                                        .notifications[index].notificationId);
                              }
                            },
                            timeAgo: notificationIndex.time,
                            description: notificationIndex.message,
                            isRead: notificationIndex.read == 1);
                      } else if (notificationIndex.type == 'unfollow') {
                        return CommonTile(
                            firstName: notificationIndex.firstName,
                            lastName: notificationIndex.lastName,
                            image: notificationIndex.image,
                            callBack: () {
                              if (state.notifications[index].read == 0) {
                                context
                                    .read<NotificationBloc>()
                                    .readNotification(state
                                        .notifications[index].notificationId);
                              }
                            },
                            timeAgo: notificationIndex.time,
                            description: notificationIndex.message,
                            isRead: notificationIndex.read == 1);
                      } else if (notificationIndex.type ==
                          'incomplete_account') {
                        return NotificationImageCard(
                            btnText: 'Add your payment account',
                            firstName: notificationIndex.firstName,
                            lastName: notificationIndex.lastName,
                            image: notificationIndex.image,
                            callBack: () {
                              if (state.notifications[index].read == 0) {
                                context
                                    .read<NotificationBloc>()
                                    .readNotification(state
                                        .notifications[index].notificationId);
                              }
                              NavRouter.push(
                                      context,
                                      EditProfileScreen(
                                          addPaymentNotification:
                                              notificationIndex.read == 0,
                                          myScheduleNotification: false))
                                  .then((value) {
                                context
                                    .read<NotificationBloc>()
                                    .fetchNotification(loading: false);
                              });
                            },
                            timeAgo: notificationIndex.time,
                            description: notificationIndex.message,
                            isRead: notificationIndex.read == 1);
                      } else if (notificationIndex.type ==
                          'unset_availability') {
                        return NotificationImageCard(
                            btnText: 'Update your schedule',
                            firstName: notificationIndex.firstName,
                            lastName: notificationIndex.lastName,
                            image: notificationIndex.image,
                            callBack: () {
                              if (state.notifications[index].read == 0) {
                                context
                                    .read<NotificationBloc>()
                                    .readNotification(state
                                        .notifications[index].notificationId);
                              }
                              NavRouter.push(
                                      context,
                                      EditProfileScreen(
                                          myScheduleNotification:
                                              notificationIndex.read == 0,
                                          addPaymentNotification: false))
                                  .then((value) {
                                context
                                    .read<NotificationBloc>()
                                    .fetchNotification(loading: false);
                              });
                            },
                            timeAgo: notificationIndex.time,
                            description: notificationIndex.message,
                            isRead: notificationIndex.read == 1);
                      } else if (notificationIndex.type == 'deduct_payment') {
                        return CommonTile(
                            firstName: notificationIndex.firstName,
                            lastName: notificationIndex.lastName,
                            image: notificationIndex.image,
                            callBack: () {
                              if (state.notifications[index].read == 0) {
                                context
                                    .read<NotificationBloc>()
                                    .readNotification(state
                                        .notifications[index].notificationId);
                              }
                            },
                            timeAgo: notificationIndex.time,
                            description: notificationIndex.message,
                            isRead: notificationIndex.read == 1);
                      } else if (notificationIndex.type == 'new_video') {
                        return NotificationImageCard(
                            firstName: notificationIndex.firstName,
                            lastName: notificationIndex.lastName,
                            image: notificationIndex.image,
                            callBack: () async {
                              if (notificationIndex.read == 0) {
                                context
                                    .read<NotificationBloc>()
                                    .readNotification(
                                        notificationIndex.notificationId)
                                    .then((value) {
                                  NavRouter.push(
                                      NavRouter
                                          .navigationKey.currentState!.context,
                                      (OtherUserProfileScreen(
                                        userId: notificationIndex.senderId,
                                      )));
                                  // NavRouter.push(
                                  //     NavRouter.navigationKey.currentState!
                                  //         .context,
                                  //     (ShortVideoHomePage(
                                  //         videoBotId:
                                  //         notificationIndex.videobot_id,
                                  //         route: 'video',
                                  //         listIndex: 0,
                                  //         videoList: videosList)));
                                });
                              } else {
                                NavRouter.push(
                                    NavRouter
                                        .navigationKey.currentState!.context,
                                    (OtherUserProfileScreen(
                                      userId: notificationIndex.senderId,
                                    )));
                                // context
                                //     .read<FetchAllVideosBloc>()
                                //     .fetchAllVideos(
                                //         currentPage: 0, limit: 10)
                                //     .then((value) {
                                //   NavRouter.push(
                                //       NavRouter.navigationKey.currentState!
                                //           .context,
                                //       (ShortVideoHomePage(
                                //           videoBotId:
                                //               notificationIndex.videobot_id,
                                //           route: 'video',
                                //           listIndex: 0,
                                //           videoList: videosList)));
                                // });
                              }
                            },
                            timeAgo: notificationIndex.time,
                            description: notificationIndex.message,
                            isRead: notificationIndex.read == 1,
                            btnText: 'Watch Video');
                        // return BlocConsumer<FetchAllVideosBloc,
                        //     FetchAllVideoState>(
                        //   listener: (context, state) {
                        //     if (state is FetchAllVideoError) {
                        //       BotToast.showText(text: state.error);
                        //     } else if (state is FetchAllVideoLoading) {
                        //       BotToast.showLoading();
                        //     } else if (state is FetchAllVideoLoaded) {
                        //       BotToast.closeAllLoading();
                        //       videosList = state.allVideos.videos_list;
                        //       // NavRouter.push(
                        //       //     NavRouter
                        //       //         .navigationKey.currentState!.context,
                        //       //     (ShortVideoHomePage(
                        //       //         videoBotId:
                        //       //             notificationIndex.videobot_id,
                        //       //         route: 'video',
                        //       //         listIndex: 0,
                        //       //         videoList: videosList)));
                        //     }
                        //   },
                        //   builder: (context, state) {
                        //     return NotificationImageCard(
                        //         firstName: notificationIndex.firstName,
                        //         lastName: notificationIndex.lastName,
                        //         image: notificationIndex.image,
                        //         callBack: () async {
                        //           if (notificationIndex.read == 0) {
                        //             context
                        //                 .read<NotificationBloc>()
                        //                 .readNotification(
                        //                     notificationIndex.notificationId)
                        //                 .then((value) {
                        //               NavRouter.push(
                        //                   NavRouter.navigationKey.currentState!
                        //                       .context,
                        //                   (ShortVideoHomePage(
                        //                       videoBotId:
                        //                           notificationIndex.videobot_id,
                        //                       route: 'video',
                        //                       listIndex: 0,
                        //                       videoList: videosList)));
                        //             });
                        //           } else {
                        //             // context
                        //             //     .read<FetchAllVideosBloc>()
                        //             //     .fetchAllVideos(
                        //             //         currentPage: 0, limit: 10)
                        //             //     .then((value) {
                        //             //   NavRouter.push(
                        //             //       NavRouter.navigationKey.currentState!
                        //             //           .context,
                        //             //       (ShortVideoHomePage(
                        //             //           videoBotId:
                        //             //               notificationIndex.videobot_id,
                        //             //           route: 'video',
                        //             //           listIndex: 0,
                        //             //           videoList: videosList)));
                        //             // });
                        //           }
                        //         },
                        //         timeAgo: notificationIndex.time,
                        //         description: notificationIndex.message,
                        //         isRead: notificationIndex.read == 1,
                        //         btnText: 'Watch Video');
                        //   },
                        // );
                      } else if (notificationIndex.type == 'new_message') {
                        return NotificationImageCard(
                            firstName: notificationIndex.firstName,
                            lastName: notificationIndex.lastName,
                            image: notificationIndex.image,
                            callBack: () {
                              if (state.notifications[index].read == 0) {
                                context
                                    .read<NotificationBloc>()
                                    .readNotification(state
                                        .notifications[index].notificationId);
                              }
                              NavRouter.push(
                                context,
                                ChatScreen(
                                  name:
                                      '${state.notifications[index].firstName} ${state.notifications[index].lastName}',
                                  image: state.notifications[index].image,
                                  receiverId:
                                      state.notifications[index].senderId,
                                  speciality:
                                      state.notifications[index].specialization,
                                  timezone: state.notifications[index].timezone,
                                  sessionRate:
                                      state.notifications[index].sessionRate,
                                ),
                              );
                            },
                            timeAgo: notificationIndex.time,
                            description: notificationIndex.message,
                            isRead: notificationIndex.read == 1,
                            btnText: 'Reply Message');
                      } else if (notificationIndex.type == 'appointment') {
                        return NotificationCard(
                          icon:
                              notificationIndex.title == 'Approved Appointment'
                                  ? notification_approved_icon
                                  : notificationIndex.title == 'New Appointment'
                                      ? notifyTimeIcon
                                      : cancel_notification,
                          userName: notificationIndex.username,
                          timeAgo: notificationIndex.time,
                          description: notificationIndex.message,
                          isRead: notificationIndex.read == 1,
                          callBack: () {
                            if (state.notifications[index].read == 0) {
                              context.read<NotificationBloc>().readNotification(
                                  state.notifications[index].notificationId);
                            }
                            NavRouter.push(
                                    context,
                                    AppointmentDetailScreen(
                                        receiverId:
                                            state.notifications[index].senderId,
                                        userId:
                                            state.notifications[index].senderId,
                                        appointmentModel: state
                                            .notifications[index]
                                            .appointmentDetail!))
                                .then((value) {
                              if (value == true) {
                                context
                                    .read<NotificationBloc>()
                                    .fetchNotification(loading: false);
                              }
                            });
                          },
                        );
                      }
                      return SizedBox();
                    })
            // Column(
            //         children: const [
            //           NotificationButtonCard(userName: state,),
            //           SizedBox(height: 10),
            //           NotificationTile(
            //               checkDetails: false,
            //               icon: notification_icon,
            //               title:
            //                   'Hooray! New version update has coming (v2.0.0)'),
            //           SizedBox(height: 10),
            //           NotificationTile(
            //               checkDetails: true,
            //               icon: notification_approved_icon,
            //               title: 'Your appointment is approved!'),
            //         ],
            //       )
            : state is NotificationLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text('No notification found'),
                  );
      }),
    );
  }
}
