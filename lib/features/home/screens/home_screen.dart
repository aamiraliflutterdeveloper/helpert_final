import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/textfield/search_textformfield.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/features/home/screens/specialist_screen.dart';
import 'package:helpert_app/features/home/widgets/home_gridview_item_widget.dart';
import 'package:helpert_app/features/new_video_upload/bloc/interest_bloc.dart';
import 'package:helpert_app/features/video/bloc/notification_count/notification_count_bloc.dart';
import 'package:helpert_app/features/video/bloc/notification_count/notification_count_state.dart';
import 'package:helpert_app/features/video/bloc/video/fetch_all_videos_bloc.dart';
import 'package:helpert_app/features/video/bloc/video/fetch_all_videos_state.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../common_widgets/fetch_svg.dart';
import '../../../constants/api_endpoints.dart';
import '../../../constants/asset_paths.dart';
import '../../../constants/text_styles.dart';
import '../../auth/repo/auth_repo.dart';
import '../../new_video_upload/screens/flick_media_player_docs/short_video_home_page.dart';
import '../../notifications/screens/notification_screen.dart';
import '../../video/model/videos_model.dart';
import '../widgets/tabs_row_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = -1;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int currentPage = 1;
  int limit = 10;

  @override
  void initState() {
    super.initState();
    context
        .read<FetchAllVideosBloc>()
        .fetchAllVideos(currentPage: currentPage, limit: limit);
    currentPage++;
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });
          await context.read<FetchAllVideosBloc>().fetchAllVideos(
              isLoading: false, currentPage: currentPage, limit: limit);
          currentPage++;
          setState(() {
            isLoading = false;
          });

          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
  }

  final controller = TextEditingController();

  List<VideoBotModel> videosList = [];

  @override
  Widget build(BuildContext context) {
    context.read<InterestBloc>().fetchAllInterest();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), // Set this height
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 38.0, bottom: 0, left: 8, right: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Image.asset(
                            helpert_logo_square_png,
                            width: 60,
                            height: 60,
                          ),
                        ),
                        Text(
                          'Helpert',
                          style: TextStyles.regularTextStyle(fontSize: 23),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<NotificationCountBloc, NotificationCountState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            NavRouter.push(context, const NotificationScreen());
                          },
                          icon: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const SvgImage(
                                path: ic_notification,
                              ),
                              if (state is NotificationCountLoaded &&
                                  state.notificationCount! > 0)
                                Positioned(
                                    top: -4,
                                    right: -4,
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: AppColors.failure,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Text(
                                          state.notificationCount.toString(),
                                          style: TextStyle(
                                              fontSize: 8,
                                              color: AppColors.pureWhite),
                                        ),
                                      ),
                                    ))
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Divider(color: AppColors.silver, height: 10),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.pureWhite,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverPadding(
              padding: EdgeInsets.only(top: 0),
              sliver: SliverAppBar(
                pinned: true,
                floating: false,
                elevation: 0,
                toolbarHeight: 0,
                collapsedHeight: null,
                automaticallyImplyLeading: false,
                expandedHeight: 85,
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    centerTitle: false,
                    background: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16) +
                          EdgeInsets.only(top: 16),
                      child: SearchTextFormField(
                        controller: controller,
                        hintText: 'Search for Experts or Career advice?',
                        enabled: false,
                        onTap: () {
                          NavRouter.push(context, const SpecialistScreen());
                        },
                      ),
                    )),
                titleSpacing: 0,
                primary: false,
              ),
            ),
            SliverAppBar(
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
                alignment: Alignment.centerLeft,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TabsRowWidget(
                      key: _listKey,
                      tabs: AuthRepo.instance.user.specializationList
                          .where((element) => element.name != 'other')
                          .toList(),
                      selectedIndex: selectedIndex,
                      onTap: (index) {
                        selectedIndex = index;
                        context.read<FetchAllVideosBloc>().tabsVideos(
                            name: selectedIndex == -1
                                ? null
                                : AuthRepo.instance.user
                                    .specializationList[selectedIndex].name);
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<FetchAllVideosBloc>().fetchAllVideos(
                isRefreshing: true,
                isLoading: false,
                currentPage: 0,
                limit: 10);
          },
          child: BlocConsumer<FetchAllVideosBloc, FetchAllVideoState>(
            listener: (context, state) {
              if (state is FetchAllVideoError) {
                BotToast.showText(text: state.error);
              }
            },
            builder: (context, state) {
              if (state is FetchAllVideoLoaded) {
                List<VideoBotModel> videosList = state.allVideos.videos_list;

                return videosList.isNotEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(
                                  bottom: isLoading ? 20 : 120,
                                  top: 16,
                                  left: 16,
                                  right: 16),
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: videosList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  HomeGridViewItemWidget(
                                deleteFunction: () {},
                                route: 'home',
                                onTap: () {
                                  NavRouter.push(
                                          context,
                                          ShortVideoHomePage(
                                              currentPage: currentPage,
                                              route: 'home',
                                              listIndex: index,
                                              videoList: videosList))
                                      .then((value) {
                                    // context
                                    //     .read<FetchAllVideosBloc>()
                                    //     .fetchAllVideos(
                                    //         currentPage: 0, limit: 10);
                                  });
                                },
                                videoImage: videosList[index].image.isNotEmpty
                                    ? '$VIDEO_BASE_URL${videosList[index].image}'
                                    : null,
                                image: videosList[index].user_image.isEmpty
                                    ? ''
                                    : videosList[index].user_image,
                                name: videosList[index].user_name,
                                speciality: videosList[index].specialization,
                                question: videosList[index].interest!.name,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3 / 4,
                                crossAxisCount: 2,
                                mainAxisSpacing: 16.0,
                                crossAxisSpacing: 16.0,
                              ),
                            ),
                          ),
                          if (isLoading)
                            Container(
                              height: Platform.isIOS ? 150 : 130,
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                height: 26,
                                width: 26,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.0,
                                ),
                              ),
                            ),
                        ],
                      )
                    : Center(child: Text('No Video found'));
              }
              if (state is FetchAllVideoError) {
                return Center(
                  child: Text('No video found'),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
