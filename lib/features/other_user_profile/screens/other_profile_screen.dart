import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/bottons/elevated_button_with_icon.dart';
import 'package:helpert_app/common_widgets/components/text_view.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/other_user_profile/bloc/other_profile_bloc.dart';
import 'package:helpert_app/features/other_user_profile/bloc/other_profile_state.dart';
import 'package:helpert_app/size_measure.dart';
import 'package:helpert_app/utils/nav_router.dart';
import 'package:readmore/readmore.dart';

import '../../../../constants/asset_paths.dart';
import '../../../common_widgets/components/custom_icon_tabbar.dart';
import '../../../common_widgets/custom_dialog.dart';
import '../../../common_widgets/fetch_svg.dart';
import '../../../constants/api_endpoints.dart';
import '../../auth/models/user_model.dart';
import '../../book_call/screens/booking_slot_screen.dart';
import '../../chat/screens/chat_screen.dart';
import '../../home/widgets/home_gridview_item_widget.dart';
import '../../new_video_upload/screens/flick_media_player_docs/short_video_home_page.dart';
import '../../profile/widgets/client_detail_box.dart';
import '../../profile/widgets/follow_card.dart';
import '../../reusable_video_list/app_data.dart';
import '../../video/bloc/video/fetch_all_videos_bloc.dart';
import '../../video/model/videos_model.dart';
import '../bloc/other_profile_video_bloc.dart';
import '../bloc/other_profile_video_state.dart';
import '../widgets/other_joined_date.dart';
import '../widgets/other_profile_widget.dart';

class OtherUserProfileScreen extends StatefulWidget {
  final int userId;
  const OtherUserProfileScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  String? description;
  bool isHidden = true;
  int hiddenLength = 2;
  bool isLoading = false;
  double descriptionHeight = 100.0;
  bool isMeasured = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    context.read<OtherProfileBloc>().getSpecificUser(widget.userId);
    context
        .read<OtherProfileVideoBloc>()
        .fetchOtherProfileVideos(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    const String text =
        "Text in one line Text in one line Text in one line Text in one line Text in one line Text in one line Text in one line Text in one lineText in one line Text in one line Text in one line Text in one line";

    return WillPopScope(
      onWillPop: () async {
        Appdata.isFollowing.isNotEmpty
            ? NavRouter.pop(context, Appdata.isFollowing[0])
            : NavRouter.pop(context);
        NavRouter.pop(context, Appdata.isFollowing[0]);
        return true;
      },
      child: BlocConsumer<OtherProfileBloc, OtherProfileState>(
        listener: (context, state) {
          if (state is OtherProfileError) {}
        },
        builder: (context, state) {
          if (state is OtherProfileLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is OtherProfileLoaded) {
            bool isDoctor = state.user.userRole == 3;

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: .5,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: IconButton(
                    splashRadius: 24,
                    icon: const SvgImage(
                      path: ic_backbutton,
                    ),
                    onPressed: () {
                      Appdata.isFollowing.isNotEmpty
                          ? NavRouter.pop(context, Appdata.isFollowing[0])
                          : NavRouter.pop(context);
                    },
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    state.user.userName,
                    style: TextStyles.boldTextStyle(fontSize: 18),
                  ),
                ),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  description = state.user.description;
                  final span = TextSpan(text: description);
                  final tp =
                      TextPainter(text: span, textDirection: TextDirection.ltr);
                  tp.layout(
                      maxWidth: MediaQuery.of(context)
                          .size
                          .width); // equals the parent screen width
                  return NestedScrollView(
                    floatHeaderSlivers: true,
                    physics: const BouncingScrollPhysics(),
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          pinned: true,
                          floating: false,
                          elevation: 0,
                          toolbarHeight: 0,
                          collapsedHeight: null,
                          automaticallyImplyLeading: false,
                          expandedHeight:
                              isDoctor ? 354 + descriptionHeight : 180,
                          flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.parallax,
                              centerTitle: false,
                              background: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 15),
                                    OtherProfileWidget(user: state.user),
                                    SizedBox(height: 14),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 110,
                                            child: FollowCard(
                                                total: 'followers',
                                                title:
                                                    '${state.user.followers}')),
                                        SizedBox(width: 15),
                                        Expanded(
                                            child: FollowCard(
                                                total: 'following',
                                                title:
                                                    '${state.user.following}'))
                                      ],
                                    ),
                                    if (isDoctor) const SizedBox(height: 10),
                                    if (isDoctor)
                                      OtherUserJoinedDateWidget(
                                          user: state.user),
                                    if (isDoctor) const SizedBox(height: 15),
                                    if (isDoctor)
                                      MeasureSize(
                                        onChange: (widgetSize) {
                                          setState(() {
                                            isMeasured = true;
                                          });
                                          // print(widgetSize.height);
                                          // print(widgetSize.width);
                                          setState(() {
                                            descriptionHeight =
                                                widgetSize.height;
                                          });
                                        },
                                        child: Visibility(
                                          maintainSize: true,
                                          maintainState: true,
                                          maintainAnimation: true,
                                          visible: isMeasured,
                                          child: ReadMoreText(
                                            '$description',
                                            trimLines: 2,
                                            style: TextStyles.mediumTextStyle(
                                                fontSize: 14),
                                            trimMode: TrimMode.Line,
                                            callback: (bool value) {
                                              if (isHidden) {
                                                descriptionHeight = 400;
                                                isHidden = false;
                                              } else {
                                                isHidden = true;
                                              }
                                              setState(() {});
                                            },
                                            trimCollapsedText: 'Show more',
                                            trimExpandedText: 'Show less',
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 15),
                                    if (isDoctor)
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: ElevatedButtonWithIcon(
                                              height: 44,
                                              prefixIcon: ic_cam_popup,
                                              text: 'Book a Call',
                                              onTap: () {
                                                if (state.user.payment_status ==
                                                        'incomplete' ||
                                                    state.user.availability ==
                                                        0) {
                                                  CustomDialogs
                                                      .showPaymentStatusNotificationDialog(
                                                          context, onOkTap: () {
                                                    if (state.user
                                                            .payment_status ==
                                                        'incomplete') {
                                                      context
                                                          .read<
                                                              FetchAllVideosBloc>()
                                                          .sendNotification(
                                                              doctorId: state
                                                                  .user.userId,
                                                              type:
                                                                  'incomplete_account');
                                                    }
                                                    if (state.user
                                                            .availability ==
                                                        0) {
                                                      context
                                                          .read<
                                                              FetchAllVideosBloc>()
                                                          .sendNotification(
                                                              doctorId: state
                                                                  .user.userId,
                                                              type:
                                                                  'unset_availability');
                                                    }
                                                    Navigator.pop(context);
                                                  });
                                                }

                                                // if (state.user.availability ==
                                                //     0) {
                                                //   CustomDialogs
                                                //       .showPaymentStatusNotificationDialog(
                                                //           context, onOkTap: () {
                                                //     context
                                                //         .read<
                                                //             FetchAllVideosBloc>()
                                                //         .sendNotification(
                                                //             state.user.userId);
                                                //     Navigator.pop(context);
                                                //   });
                                                // }
                                                else {
                                                  NavRouter.push(
                                                    context,
                                                    BookingSlotScreen(
                                                      doctorId:
                                                          state.user.userId,
                                                      doctorImage:
                                                          state.user.image,
                                                      doctorName:
                                                          '${state.user.firstName} ${state.user.lastName}',
                                                      specialization: state
                                                          .user.specialization,
                                                      sessionRate: state
                                                          .user.sessionRate!,
                                                      timeZone:
                                                          state.user.timezone,
                                                    ),
                                                  );
                                                }
                                              },
                                              primaryColor: AppColors.acmeBlue,
                                              borderColor: AppColors.acmeBlue,
                                              onPrimaryColor:
                                                  AppColors.pureWhite,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            flex: 5,
                                            child: ElevatedButtonWithIcon(
                                              fontSize:
                                                  state.user.isFollow ? 13 : 15,
                                              height: 44,
                                              text: state.user.isFollow
                                                  ? 'UnFollow'
                                                  : 'Follow',
                                              onTap: () {
                                                context
                                                    .read<OtherProfileBloc>()
                                                    .followUnFollow(
                                                        widget.userId);
                                                if (state.user.isFollow) {
                                                  Appdata.isFollowing.clear();
                                                  Appdata.isFollowing.add(1);
                                                  setState(() {});
                                                } else {
                                                  Appdata.isFollowing.clear();
                                                  Appdata.isFollowing.add(0);
                                                  setState(() {});
                                                }
                                              },
                                              prefixIcon: state.user.isFollow
                                                  ? ic_minus
                                                  : plus_icon_button,
                                              primaryColor: AppColors.pureWhite,
                                              borderColor: AppColors.silver,
                                              onPrimaryColor:
                                                  AppColors.acmeBlue,
                                              prefixHeight: 12,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            flex: 2,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor:
                                                    AppColors.acmeBlue,
                                                backgroundColor:
                                                    AppColors.pureWhite,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    side: BorderSide(
                                                      width: 1.0,
                                                      color: AppColors.silver,
                                                    )),
                                                elevation: 0,
                                              ),
                                              onPressed: () {
                                                NavRouter.push(
                                                  context,
                                                  ChatScreen(
                                                    name:
                                                        '${state.user.firstName} ${state.user.lastName}',
                                                    image: state.user.image,
                                                    receiverId:
                                                        state.user.userId,
                                                    speciality: state
                                                        .user.specialization,
                                                    timezone:
                                                        state.user.timezone,
                                                    sessionRate: state
                                                            .user.sessionRate ??
                                                        0,
                                                  ),
                                                );
                                              },
                                              child: SvgImage(
                                                color: AppColors.acmeBlue,
                                                path: ic_message,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (isDoctor) const SizedBox(height: 16),
                                    if (isDoctor)
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFEEF4FF),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ClientDetailsBox(
                                                total:
                                                    '\$${state.user.sessionRate}',
                                                title: 'Session Rate'),
                                            SizedBox(width: 15),
                                            ClientDetailsBox(
                                                total: '50k+',
                                                title: 'Happy Clients'),
                                            SizedBox(width: 15),
                                            ClientDetailsBox(
                                                total: '50k+', title: 'Booked'),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              )),
                          titleSpacing: 0,
                          primary: false,
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverAppBar(
                            elevation: 0,
                            pinned: true,
                            forceElevated: true,
                            primary: false,
                            automaticallyImplyLeading: false,
                            expandedHeight: 60,
                            collapsedHeight: null,
                            toolbarHeight: 50,
                            titleSpacing: 0,
                            title: Align(
                              alignment: Alignment.topCenter,
                              child: CustomIconTabBar(
                                  controller: _controller,
                                  tabs: const ['Videobots', 'Portfolio'],
                                  onTap: (index) {
                                    setState(() {});
                                  },
                                  icon: const [
                                    ic_video_bots_icon,
                                    ic_portfolio_icon
                                  ]),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      controller: _controller,
                      children: [
                        const VideoBotsWidget(),
                        PortfolioWidget(user: state.user),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: .5,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: IconButton(
                    splashRadius: 24,
                    icon: const SvgImage(
                      path: ic_backbutton,
                    ),
                    onPressed: () {
                      NavRouter.pop(context);
                    },
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    '',
                    style: TextStyles.boldTextStyle(fontSize: 18),
                  ),
                ),
              ),
              body: Center(child: Text('Something went wrong')));
        },
      ),
    );
  }
}

class VideoBotsWidget extends StatefulWidget {
  const VideoBotsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<VideoBotsWidget> createState() => _VideoBotsWidgetState();
}

class _VideoBotsWidgetState extends State<VideoBotsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtherProfileVideoBloc, OtherProfileVideoState>(
      builder: (context, state) {
        if (state is OtherProfileVideoLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is OtherProfileVideoLoaded) {
          List<VideoBotModel> videosList = state.otherUserVideos.videos_list;

          List<VideoBotModel> allVideos = [];
          allVideos.addAll(videosList);
          if (videosList.isEmpty) {
            return Center(child: Text("Your Video Bots Are Empty."));
          } else {
            return Center(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20) +
                    EdgeInsets.only(bottom: 70),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allVideos.length,
                itemBuilder: (BuildContext context, int index) =>
                    HomeGridViewItemWidget(
                        deleteFunction: () {},
                        route: 'otherProfile',
                        onTap: () {
                          NavRouter.push(
                              context,
                              ShortVideoHomePage(
                                  route: 'profile',
                                  listIndex: index,
                                  videoList: allVideos));
                        },
                        image: videosList[index].user_image.isEmpty
                            ? ''
                            : videosList[index].user_image,
                        videoImage: videosList[index].image.isNotEmpty
                            ? '$VIDEO_BASE_URL${videosList[index].image}'
                            : null,
                        name: allVideos[index].user_name,
                        speciality: allVideos[index].specialization,
                        question: allVideos[index].interest!.name),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 4,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
              ),
            );
          }
        }
        return Center(
          child: Text("Your Video Bots Are Empty."),
        );
      },
      listener: (context, state) {
        if (state is OtherProfileVideoError) {
          BotToast.showText(text: state.error);
        }
      },
    );
  }
}

class PortfolioWidget extends StatefulWidget {
  final UserModel user;
  const PortfolioWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<PortfolioWidget> createState() => _PortfolioWidgetState();
}

class _PortfolioWidgetState extends State<PortfolioWidget> {
  /// Needs Comments ...
  DateTime currentDate = DateTime.now();

  String? dateDifference;

  vehicleAge(DateTime currentDate, DateTime dt) {
    Duration parse = currentDate.difference(dt).abs();
    dateDifference =
        "${parse.inDays ~/ 360} Years ${((parse.inDays % 360) ~/ 30)} Month";
    return "${parse.inDays ~/ 360} Years ${((parse.inDays % 360) ~/ 30)} Month";
    // ${(parse.inDays % 360) % 30} Days
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.user.userSecondDetailLIst.length,
      itemBuilder: (context, index) {
        DateTime dt = DateTime.parse(
            widget.user.userSecondDetailLIst[index].joining_date);
        vehicleAge(currentDate, dt);

        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Card(
                elevation: 10,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextView(
                            'Experience',
                            textStyle: TextStyles.boldTextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 14),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  'Company',
                                  textStyle: TextStyles.regularTextStyle(
                                      textColor: AppColors.moon, fontSize: 13),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  widget.user.userSecondDetailLIst[index]
                                              .company !=
                                          null
                                      ? '${widget.user.userSecondDetailLIst[index].company}'
                                      : widget.user.userSecondDetailLIst[index]
                                          .companys!.name,
                                  style: TextStyles.regularTextStyle(),
                                ),
                                // TextView(
                                //   '${AuthRepo.instance.user.company}',
                                //   textStyle:
                                //       TextStyles.regularTextStyle(),
                                // ),
                                SizedBox(height: 10),

                                TextView(
                                  widget.user.userSecondDetailLIst[index]
                                          .end_date.isEmpty
                                      ? '${widget.user.userSecondDetailLIst[index].joining_date} - Present • $dateDifference'
                                      : '${widget.user.start_date} - ${widget.user.userSecondDetailLIst[index].end_date}',
                                  textStyle: TextStyles.regularTextStyle(
                                      textColor: AppColors.moon, fontSize: 13),
                                ),

                                // TextView(
                                //   end_date.isEmpty
                                //       ? '${AuthRepo.instance.user.start_date} - Present • $dateDifference'
                                //       : '${AuthRepo.instance.user.start_date} - $end_date',
                                //   textStyle: TextStyles.regularTextStyle(
                                //       textColor: AppColors.moon,
                                //       fontSize: 13),
                                // ),
                                SizedBox(height: 20),
                                TextView(
                                  'I am',
                                  textStyle: TextStyles.regularTextStyle(
                                      textColor: AppColors.moon, fontSize: 13),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  widget.user.userSecondDetailLIst[index]
                                              .expertise !=
                                          null
                                      ? '${widget.user.userSecondDetailLIst[index].expertise}'
                                      : widget.user.userSecondDetailLIst[index]
                                          .iam!.name,
                                  style: TextStyles.regularTextStyle(),
                                ),
                                // TextView(
                                //   '${AuthRepo.instance.user.iam}',
                                //   textStyle:
                                //       TextStyles.regularTextStyle(),
                                // ),
                                SizedBox(height: 20),
                                TextView(
                                  'Specialized in',
                                  textStyle: TextStyles.regularTextStyle(
                                      textColor: AppColors.moon, fontSize: 13),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  widget.user.userSecondDetailLIst[index]
                                              .specialization !=
                                          null
                                      ? '${widget.user.userSecondDetailLIst[index].specialization}'
                                      : widget.user.userSecondDetailLIst[index]
                                          .specializations!.name,
                                  style: TextStyles.regularTextStyle(),
                                ),
                                // TextView(
                                //   '${AuthRepo.instance.user.specialization}',
                                //   textStyle:
                                //       TextStyles.regularTextStyle(),
                                // ),
                                SizedBox(height: 20),
                                TextView(
                                  'Location',
                                  textStyle: TextStyles.regularTextStyle(
                                      textColor: AppColors.moon, fontSize: 13),
                                ),
                                SizedBox(height: 8),
                                TextView(
                                  '${widget.user.userSecondDetailLIst[index].location}',
                                  textStyle: TextStyles.regularTextStyle(),
                                ),
                                SizedBox(height: 20),
                                TextView(
                                  'Your Expertise',
                                  textStyle: TextStyles.regularTextStyle(
                                      textColor: AppColors.moon, fontSize: 13),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${widget.user.userSecondDetailLIst[index].description}',
                                  style: TextStyles.regularTextStyle(
                                      fontSize: 13.5),
                                ),
                                // TextView(
                                //   '${AuthRepo.instance.user.description}',
                                //   textStyle:
                                //       TextStyles.regularTextStyle(),
                                // ),
                              ],
                            ),
                          )
                        ]))));
      },
    );
  }
}

// class PortfolioWidget extends StatefulWidget {
//   final UserModel user;
//   const PortfolioWidget({Key? key, required this.user}) : super(key: key);
//
//   @override
//   State<PortfolioWidget> createState() => _PortfolioWidgetState();
// }
//
// class _PortfolioWidgetState extends State<PortfolioWidget> {
//   String? end_date;
//
//   /// Needs Comments ...
//   DateTime currentDate = DateTime.now();
//
//   DateTime? dt;
//
//   String? dateDifference;
//
//   vehicleAge(DateTime currentDate, DateTime dt) {

//
//     Duration parse = currentDate.difference(dt).abs();
//     dateDifference =
//         "${parse.inDays ~/ 360} Years ${((parse.inDays % 360) ~/ 30)} Month";
//     return "${parse.inDays ~/ 360} Years ${((parse.inDays % 360) ~/ 30)} Month";
//     // ${(parse.inDays % 360) % 30} Days
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     dt = DateTime.parse(widget.user.start_date);
//     end_date = '${widget.user.end_date}';
//     vehicleAge(currentDate, dt!);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14.0),
//       child: Card(
//         elevation: 10,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: ListView(
//             shrinkWrap: true,
//             padding: EdgeInsets.zero,
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             // mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: 20),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextView(
//                     'Experience',
//                     textStyle: TextStyles.boldTextStyle(fontSize: 14),
//                   ),
//                   SizedBox(height: 14),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextView(
//                           'Company',
//                           textStyle: TextStyles.regularTextStyle(
//                               textColor: AppColors.moon, fontSize: 13),
//                         ),
//                         SizedBox(height: 8),
//                         TextView(
//                           '${widget.user.company}',
//                           textStyle: TextStyles.regularTextStyle(),
//                         ),
//                         SizedBox(height: 10),
//                         TextView(
//                           end_date!.isEmpty
//                               ? '${widget.user.start_date} - Present • $dateDifference'
//                               : '${widget.user.start_date} - $end_date',
//                           textStyle: TextStyles.regularTextStyle(
//                               textColor: AppColors.moon, fontSize: 13),
//                         ),
//                         SizedBox(height: 20),
//                         TextView(
//                           'I am',
//                           textStyle: TextStyles.regularTextStyle(
//                               textColor: AppColors.moon, fontSize: 13),
//                         ),
//                         SizedBox(height: 8),
//                         TextView(
//                           '${widget.user.iam}',
//                           textStyle: TextStyles.regularTextStyle(),
//                         ),
//                         SizedBox(height: 20),
//                         TextView(
//                           'Specialized in',
//                           textStyle: TextStyles.regularTextStyle(
//                               textColor: AppColors.moon, fontSize: 13),
//                         ),
//                         SizedBox(height: 8),
//                         TextView(
//                           '${widget.user.specialization}',
//                           textStyle: TextStyles.regularTextStyle(),
//                         ),
//                         SizedBox(height: 20),
//                         TextView(
//                           'Location',
//                           textStyle: TextStyles.regularTextStyle(),
//                         ),
//                         SizedBox(height: 8),
//                         TextView(
//                           '${widget.user.location}',
//                           textStyle: TextStyles.regularTextStyle(
//                               textColor: AppColors.moon, fontSize: 13),
//                         ),
//                         SizedBox(height: 20),
//                         TextView(
//                           'Your Expertise',
//                           textStyle: TextStyles.regularTextStyle(
//                               textColor: AppColors.moon, fontSize: 13),
//                         ),
//                         SizedBox(height: 8),
//                         TextView(
//                           '${widget.user.description}',
//                           textStyle: TextStyles.regularTextStyle(),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
