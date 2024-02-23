import 'package:flutter/material.dart';

import '../../../../common_widgets/bottons/elevated_button_without_icon.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/text_styles.dart';
import '../../../../utils/nav_router.dart';

class CongratulationCard extends StatelessWidget {
  const CongratulationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                spreadRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 1.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 4),
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Congratulation!",
                      style: TextStyles.boldTextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your chat bot has been ready to publish",
                      style: TextStyles.mediumTextStyle(
                          fontSize: 14, textColor: AppColors.moon),
                    ),
                    SizedBox(height: 45),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: ElevatedButtonWithoutIcon(
                                    primaryColor: AppColors.pureWhite,
                                    borderColor: AppColors.moon,
                                    textColor: AppColors.black,
                                    text: 'Cancel',
                                    onPressed: () {
                                      NavRouter.pop(context);
                                      // clearVideoModuleLists();
                                      // Navigator.of(context)
                                      //     .popUntil((route) => route.isFirst);
                                    })),
                            SizedBox(width: 10),
                            // Expanded(
                            //     child: BlocConsumer<VideoBloc, VideoState>(
                            //   listener: (context, state) {
                            //     if (state is VideoLoading) {
                            //       BotToast.showLoading();
                            //     }
                            //     if (state is VideoLoaded) {
                            //       BotToast.closeAllLoading();
                            //       Navigator.of(context)
                            //           .popUntil((route) => route.isFirst);
                            //       clearVideoModuleLists();
                            //       VideoModule.topic.clear();
                            //       VideoModule.introVideo.clear();
                            //       VideoModule.videoQuestions.clear();
                            //     }
                            //     if (state is VideoError) {
                            //       BotToast.closeAllLoading();
                            //       BotToast.showText(text: state.error);
                            //     }
                            //   },
                            //   builder: (context, state) {
                            //     return ElevatedButtonWithoutIcon(
                            //         primaryColor: AppColors.acmeBlue,
                            //         borderColor: AppColors.acmeBlue,
                            //         textColor: AppColors.pureWhite,
                            //         text: 'Publish',
                            //         onPressed: () {
                            //           if (VideoModule.defaultVideo.isNotEmpty) {
                            //             // context.read<VideoBloc>().publishVideo(
                            //             //       VideoModule.categoryList[0],
                            //             //       VideoModule.defaultVideo[0],
                            //             //       VideoModule.introVideo[0],
                            //             //       VideoModule.videoList,
                            //             //       VideoModule.videoQuestions,
                            //             //       VideoModule.topic[0],
                            //             //     );
                            //           } else {
                            //             BotToast.showText(
                            //                 text:
                            //                     'Please add answer for the unrelated question');
                            //           }
                            //         });
                            //   },
                            // )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
