import 'package:flutter/material.dart';
import 'package:helpert_app/core/data/video_data.dart';

import '../../../../common_widgets/bottons/custom_elevated_button.dart';
import '../../../../common_widgets/textfield/custom_textformfield.dart';
import '../../../../constants/text_styles.dart';
import '../../../../utils/nav_router.dart';
import '../../../new_video_upload/screens/new_camera_screen.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key? key,
    required this.disable,
  }) : super(key: key);

  final bool disable;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final categoryController = TextEditingController();
  String categoryId = '';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  // physics: const ClampingScrollPhysics(),
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Create your video chat bots",
                      style: TextStyles.regularTextStyle(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "When users visit’s your profile and ask questions these videos will be played, Which resembles to 1 on 1 video call.  so record the videos for most questions asked to you by your followers.",
                      textAlign: TextAlign.center,
                      style: TextStyles.regularTextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 25),
                    CustomTextFormField(
                        readOnly: false,
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => DropdownScreen(
                          //             list: context.read<VideoBloc>().interests,
                          //             title: 'Categories'))).then((value) {
                          //   categoryController.text = value[0];
                          //   categoryId = value[1].toString();
                          //   setState(() {});
                          // });
                        },
                        keyboardType: TextInputType.text,
                        controller: categoryController,
                        labelText: 'select category',
                        onChanged: (val) {
                          setState(() {});
                          // validateButton();
                        }),
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        disable: widget.disable,
                        title: 'Continue Recording',
                        onTap: () async {
                          // if (VideoModule.topic.isNotEmpty) {
                          //   VideoModule.topic.clear();
                          // }
                          if (categoryController.text.isEmpty) {
                            NavRouter.push(context, NewCameraScreen())
                                .then((value) {
                              // StatusBarStyles.lightStatusAndNavigationBar();
                            });
                            // BotToast.showText(text: 'please select category');
                          } else {
                            // print('else');
                            // PermissionStatus status =
                            //     await Permission.camera.request();
                            // print('status is :: $status');
                            // if (status.isGranted) {
                            //   PermissionStatus status =
                            //       await Permission.microphone.request();
                            //   if (status.isGranted) {
                            //     VideoModule.categoryList.add(categoryId);
                            //     // NavRouter.push(context, CarouselSliderPage());
                            //     // NavRouter.push(
                            //     //     context, IdleVideoCameraScreen());
                            //   }
                            // } else if (status.isDenied) {
                            //   print('permanently denied');
                            //   PermissionStatus status =
                            //       await Permission.camera.request();
                            }
                            VideoModule.categoryList.add(categoryId);
                            // NavRouter.push(context, CarouselSliderPage());
                            NavRouter.push(context, NewCameraScreen())
                                .then((value) {
                              // StatusBarStyles.lightStatusAndNavigationBar();
                            });
                          }
                        // },
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
