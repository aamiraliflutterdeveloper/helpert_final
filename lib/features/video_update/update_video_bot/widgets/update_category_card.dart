// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:helpert_app/core/data/video_data.dart';
// import 'package:helpert_app/features/video/bloc/video/video_bloc.dart';
// import 'package:helpert_app/features/video/model/videos_model.dart';
//
// import '../../../../common_widgets/bottons/custom_elevated_button.dart';
// import '../../../../common_widgets/textfield/custom_textformfield.dart';
// import '../../../../constants/text_styles.dart';
// import '../../../../utils/nav_router.dart';
// import '../../../auth/screens/register/drop_down_screen.dart';
// import '../screens/update_intro_video_screen.dart';
//
// class UpdateCategoryCard extends StatefulWidget {
//   const UpdateCategoryCard({
//     Key? key,
//     required this.videoBot,
//     required this.disable,
//   }) : super(key: key);
//
//   final bool disable;
//   final VideoBotModel videoBot;
//
//   @override
//   State<UpdateCategoryCard> createState() => _UpdateCategoryCardState();
// }
//
// class _UpdateCategoryCardState extends State<UpdateCategoryCard> {
//   final categoryController = TextEditingController();
//   int? categoryId;
//
//   @override
//   void initState() {
//     categoryController.text = widget.videoBot.interest!.name;
//     categoryId = widget.videoBot.interest!.id;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 20,
//                 spreadRadius: 4,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 Expanded(
//                     child: Column(
//                   // physics: const ClampingScrollPhysics(),
//                   children: [
//                     SizedBox(height: 20),
//                     Text(
//                       "Update your video chat bots",
//                       style: TextStyles.regularTextStyle(),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "When users visit’s your profile and ask questions these videos will be played, Which resembles to 1 on 1 video call.  so record the videos for most questions asked to you by your followers.",
//                       textAlign: TextAlign.center,
//                       style: TextStyles.regularTextStyle(fontSize: 13),
//                     ),
//                     SizedBox(height: 25),
//                     CustomTextFormField(
//                         readOnly: false,
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => DropdownScreen(
//                                       list: context.read<VideoBloc>().interests,
//                                       title: 'Categories'))).then((value) {
//                             categoryController.text = value[0];
//                             categoryId = value[1];
//                             setState(() {});
//                           });
//                         },
//                         keyboardType: TextInputType.text,
//                         controller: categoryController,
//                         labelText: 'select category',
//                         onChanged: (val) {
//                           setState(() {});
//                         }),
//                     Spacer(),
//                     SizedBox(
//                       width: double.infinity,
//                       child: CustomElevatedButton(
//                         disable: widget.disable,
//                         title: 'Continue Recording',
//                         onTap: () {
//                           // if (VideoModule.topic.isNotEmpty) {
//                           //   VideoModule.topic.clear();
//                           // }
//                           if (categoryController.text.isEmpty) {
//                             BotToast.showText(text: 'please select category');
//                           } else {
//                             VideoModule.categoryList.add(categoryId);
//                             NavRouter.push(
//                                 context,
//                                 UpdateIntroVideoScreen(
//                                     videoBot: widget.videoBot));
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                   ],
//                 ))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
