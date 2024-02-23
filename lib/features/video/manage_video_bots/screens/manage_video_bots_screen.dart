import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/bottons/custom_elevated_button.dart';
import 'package:helpert_app/common_widgets/bottons/elevated_button_without_icon.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/auth/screens/register/specialization_detail_screen.dart';
import 'package:helpert_app/features/new_video_upload/bloc/fetch_user_video_bloc.dart';
import 'package:helpert_app/features/profile/bloc/profile_bloc.dart';
import 'package:helpert_app/features/reusable_video_list/app_data.dart';
import 'package:helpert_app/features/video/bloc/video/delete_video_bloc.dart';
import 'package:helpert_app/features/video/bloc/video/delete_video_state.dart';
import 'package:helpert_app/features/video/bloc/video/fetch_all_videos_bloc.dart';
import 'package:helpert_app/features/video/model/videos_model.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../new_video_upload/bloc/fetch_user_video_state.dart';
import '../../../new_video_upload/screens/new_camera_screen.dart';
import '../../bloc/recommended_question/recommended_question_cubit.dart';

class ManageVideoBotsScreen extends StatefulWidget {
  const ManageVideoBotsScreen({Key? key}) : super(key: key);

  @override
  State<ManageVideoBotsScreen> createState() => _ManageVideoBotsScreenState();
}

class _ManageVideoBotsScreenState extends State<ManageVideoBotsScreen> {
  bool disable = false;

  @override
  void initState() {
    context.read<FetchUserVideoBloc>().fetchCurrentUserVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: const CustomAppBar(
        title: 'Manage Videobots',
      ),
      body: AllVideosBots(),
    );
  }
}

class AllVideosBots extends StatefulWidget {
  const AllVideosBots({
    Key? key,
  }) : super(key: key);

  @override
  State<AllVideosBots> createState() => _AllVideosBotsState();
}

class _AllVideosBotsState extends State<AllVideosBots> {
  List<VideoBotModel> videos_list = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: BlocBuilder<FetchUserVideoBloc, FetchUserVideoState>(
            builder: (context, state) {
              if (state is FetchUserVideoLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is FetchUserVideoLoaded) {
                videos_list = state.currentUserVideos.videos_list;
                if (videos_list.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      EmptyVideoBots(),
                      SizedBox(height: 30),
                      IntroduceText(),
                      SizedBox(height: 25),
                      ServicesOfferText(),
                    ],
                  );
                } else {
                  return Container(
                    color: const Color(0xFFF5F5F5),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      itemCount: state.currentUserVideos.videos_list.length,
                      itemBuilder: (context, index) {
                        return VideoBotsTile(
                            onPressed: () {
                              context.read<DeleteVideoBloc>().deleteVideo(
                                  videos_list[index].video_bots_id);
                              videos_list.remove(videos_list[index]);
                              setState(() {});
                            },
                            videoBots: videos_list[index]);
                      },
                    ),
                  );
                }
              } else if (state is FetchUserVideoError) {
                return Center(child: Text(state.error));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  EmptyVideoBots(),
                  SizedBox(height: 30),
                  IntroduceText(),
                  SizedBox(height: 25),
                  ServicesOfferText(),
                ],
              );
            },
          ),
        ),
        SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: BlocConsumer<RecommendedQuestionCubit,
                  RecommendedQuestionState>(listener: (context, state) {
                if (state is RecommendedQuestionLoading) {
                  BotToast.showLoading();
                } else if (state is RecommendedQuestionError) {
                  BotToast.closeAllLoading();
                  BotToast.showText(text: state.error);
                } else if (state is RecommendedQuestionLoaded) {
                  BotToast.closeAllLoading();
                  if (AuthRepo.instance.getUserRole() == '3') {
                    if (AuthRepo.instance.user.availability == 1) {
                      Appdata.recommendedQuestions = state.recommended;
                      NavRouter.push(context, NewCameraScreen()).then((value) {
                        context
                            .read<FetchUserVideoBloc>()
                            .fetchCurrentUserVideo();
                        context
                            .read<FetchAllVideosBloc>()
                            .fetchAllVideos(currentPage: 0, limit: 10);
                        setState(() {});
                      });
                    } else {
                      Appdata.recommendedQuestions = state.recommended;
                      NavRouter.push(context, NewCameraScreen()).then((value) {
                        context
                            .read<FetchUserVideoBloc>()
                            .fetchCurrentUserVideo();
                        context
                            .read<FetchAllVideosBloc>()
                            .fetchAllVideos(currentPage: 0, limit: 10);
                        setState(() {});
                      });
                      // CustomDialogs.showDayNotAvailableDialog(
                      //     context, 'Please set your availability in setting',
                      //     onOkSelection: () {
                      //   NavRouter.pop(context);
                      // });
                    }
                  } else {
                    NavRouter.push(
                        context,
                        SpecializationDetailScreen(
                          allListModel: state.recommended,
                        )).then((value) {
                      context.read<ProfileBloc>().fetchProfile(loading: false);
                    });
                  }
                }
              }, builder: (context, state) {
                return CustomElevatedButton(
                    title: 'Create New Videobots',
                    onTap: () {
                      if (AuthRepo.instance.getUserRole() == '3') {
                        context
                            .read<RecommendedQuestionCubit>()
                            .getRecommendedQuestionList();
                      } else {
                        context.read<RecommendedQuestionCubit>().getDataLists();
                      }
                    });
              }),
            ))
      ],
    );
  }
}

class VideoBotsTile extends StatefulWidget {
  final VideoBotModel videoBots;
  final VoidCallback onPressed;

  const VideoBotsTile({
    required this.videoBots,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<VideoBotsTile> createState() => _VideoBotsTileState();
}

class _VideoBotsTileState extends State<VideoBotsTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xFFF5F5F5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(18), // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(25), // Image radius
                                child: CachedNetworkImage(
                                    imageUrl:
                                        "$APP_URL${widget.videoBots.image}",
                                    fit: BoxFit.cover),
                              ),
                            )
                            // child: CircleAvatar(
                            //   radius: 25,
                            //   backgroundImage: AssetImage(videoBots.image),
                            // ),
                            ),
                        const SizedBox(width: 15),
                        Flexible(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Topic',
                                style: TextStyles.mediumTextStyle(
                                    textColor: AppColors.moon, fontSize: 12),
                              ),
                              SizedBox(
                                child: Text(
                                  widget.videoBots.main_title,
                                  style:
                                      TextStyles.mediumTextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Published',
                          style: TextStyles.mediumTextStyle(
                              textColor: AppColors.success, fontSize: 12),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 74,
                          child: ElevatedButtonWithoutIcon(
                            height: 36,
                            onPressed: () {
                              // NavRouter.push(
                              //     context,
                              //     UpdateTopicScreen(
                              //         videoBot: widget.videoBots));
                            },
                            text: 'Edit',
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 74,
                          child:
                              BlocListener<DeleteVideoBloc, DeleteVideoState>(
                            listener: (context, state) {},
                            child: ElevatedButtonWithoutIcon(
                              height: 36,
                              onPressed: widget.onPressed,
                              text: 'Delete',
                              primaryColor: AppColors.failure,
                              borderColor: AppColors.failure,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class ServicesOfferText extends StatelessWidget {
  const ServicesOfferText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Text(
        'Let people know how you can help them and what services you can offer?',
        textAlign: TextAlign.center,
        style: TextStyles.regularTextStyle(fontSize: 14),
      ),
    );
  }
}

class IntroduceText extends StatelessWidget {
  const IntroduceText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Introduce yourself",
      style: TextStyles.regularTextStyle(fontSize: 14),
    );
  }
}

class EmptyVideoBots extends StatelessWidget {
  const EmptyVideoBots({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Text(
        "Your videobots are empty create videobots",
        textAlign: TextAlign.center,
        style: TextStyles.regularTextStyle(fontSize: 14),
      ),
    );
  }
}
