import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/video/bloc/recommended_question/recommended_question_cubit.dart';

import '../../constants/app_colors.dart';
import '../../constants/asset_paths.dart';
import '../../core/data/navbar_item_model.dart';
import '../../features/auth/repo/auth_repo.dart';
import '../../features/auth/screens/register/specialization_detail_screen.dart';
import '../../features/new_video_upload/screens/new_camera_screen.dart';
import '../../features/profile/bloc/profile_bloc.dart';
import '../../features/video/bloc/notification_count/appointment_count_bloc.dart';
import '../../features/video/bloc/notification_count/appointment_count_state.dart';
import '../../features/video/bloc/notification_count/message_count_bloc.dart';
import '../../features/video/bloc/notification_count/message_count_state.dart';
import '../../utils/nav_router.dart';
import '../bottom_navbar_item_widget.dart';
import '../fetch_svg.dart';

class CustomBottomAppbar extends StatefulWidget {
  const CustomBottomAppbar({
    Key? key,
    required this.currentIndex,
    required this.onChanged,
  }) : super(key: key);
  final int currentIndex;
  final Function(int index) onChanged;

  @override
  State<CustomBottomAppbar> createState() => _CustomBottomAppbarState();
}

class _CustomBottomAppbarState extends State<CustomBottomAppbar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8,
      color: AppColors.pureWhite,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            navBarItems.length,
            (index) => InkWell(
              splashColor: AppColors.moon,
              radius: 30,
              onTap: () {
                widget.onChanged(index);
              },
              child: index == 2
                  ? Container(
                      width: 44,
                      height: 44,
                      margin: EdgeInsets.only(bottom: 8),
                      child: BlocConsumer<RecommendedQuestionCubit,
                          RecommendedQuestionState>(listener: (context, state) {
                        if (state is RecommendedQuestionLoading) {
                          BotToast.showLoading();
                        } else if (state is RecommendedQuestionError) {
                          BotToast.closeAllLoading();
                          BotToast.showText(text: state.error);
                        } else if (state is HomeQuestionsLoaded) {
                          BotToast.closeAllLoading();
                          if (AuthRepo.instance.getUserRole() == '3') {
                            NavRouter.push(context, NewCameraScreen())
                                .then((value) {
                              // context
                              //     .read<FetchUserVideoBloc>()
                              //     .fetchCurrentUserVideo();
                              // context
                              //     .read<FetchAllVideosBloc>()
                              //     .fetchAllVideos(currentPage: 0, limit: 10);
                              // setState(() {});
                            });
                          } else {
                            NavRouter.push(
                                context,
                                SpecializationDetailScreen(
                                  allListModel: state.recommended,
                                )).then((value) {
                              context
                                  .read<ProfileBloc>()
                                  .fetchProfile(loading: false);
                            });
                          }
                        }
                      }, builder: (context, state) {
                        return FloatingActionButton(
                          backgroundColor: AppColors.acmeBlue,
                          onPressed: () {
                            // wantToChangeState = true;
                            widget.onChanged(index);
                            if (AuthRepo.instance.getUserRole() == '3') {
                              context
                                  .read<RecommendedQuestionCubit>()
                                  .getRecommendedQuestionList(isFromHome: true);
                            } else {
                              context
                                  .read<RecommendedQuestionCubit>()
                                  .getDataLists(
                                    isFromHome: true,
                                  );
                            }
                          },
                          child: const SvgImage(
                            path: ic_plus,
                            width: 20,
                            height: 20,
                          ),
                        );
                      }),
                    )
                  : index == 1
                      ? BlocConsumer<AppointmentCountBloc,
                          AppointmentCountState>(listener: (context, state) {
                          if (state is AppointmentCountLoaded) {
                            print(state.appointmentCount);
                          }
                        }, builder: (context, state) {
                          return BottomNavBarItemWidget(
                              icon: navBarItems[index].icon,
                              title: navBarItems[index].title,
                              alert: state is AppointmentCountLoaded &&
                                  state.appointmentCount > 0,
                              enabled: widget.currentIndex == index);
                        })
                      : index == 3
                          ? BlocConsumer<MessageCountBloc, MessageCountState>(
                              listener: (context, state) {
                              if (state is MessageCountLoaded) {
                                print(state.messageCount);
                              }
                            }, builder: (context, state) {
                              return BottomNavBarItemWidget(
                                  icon: navBarItems[index].icon,
                                  title: navBarItems[index].title,
                                  alert: state is MessageCountLoaded &&
                                      state.messageCount > 0,
                                  enabled: widget.currentIndex == index);
                            })
                          : BottomNavBarItemWidget(
                              icon: navBarItems[index].icon,
                              title: navBarItems[index].title,
                              enabled: widget.currentIndex == index),
            ),
          ),
        ),
      ),
    );
  }
}
