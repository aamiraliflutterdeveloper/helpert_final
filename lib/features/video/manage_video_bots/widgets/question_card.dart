// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:helpert_app/constants/app_colors.dart';
//
// import '../../../../common_widgets/bottons/custom_elevated_button.dart';
// import '../../../../common_widgets/textfield/custom_textformfield.dart';
// import '../../../../constants/text_styles.dart';
// import '../../../../core/data/video_data.dart';
// import '../../../../utils/nav_router.dart';
// import '../screens/new_add_video_bot/slider_video_player/idle_video_module/idle_video_camera_screen.dart';
// import '../screens/unrelated_question_screen.dart';
//
// class QuestionCard extends StatefulWidget {
//   const QuestionCard({
//     Key? key,
//     required this.disable,
//   }) : super(key: key);
//
//   final bool disable;
//
//   @override
//   State<QuestionCard> createState() => _QuestionCardState();
// }
//
// class _QuestionCardState extends State<QuestionCard> {
//   int count = 0;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   static List<String> friendsList = [''];
//   @override
//   void initState() {
//     if (VideoModule.nameTECs.isEmpty)
//       VideoModule.nameTECs.add(TextEditingController());
//     super.initState();
//   }
//
//   void validateAndSave() {
//     final FormState? form = _formKey.currentState;
//     if (form!.validate()) {
//     } else {}
//   }
//
//   // List<String>? questions;
//   int index = 0;
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
//                   color: Colors.black12,
//                   blurRadius: 20,
//                   spreadRadius: 4,
//                   offset: Offset(0, 3)),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 Text(
//                     "What are commonly / frequently asked questions to you, by your followers",
//                     textAlign: TextAlign.center,
//                     style: TextStyles.boldTextStyle(fontSize: 14)),
//                 SizedBox(height: 25),
//                 Form(
//                   key: _formKey,
//                   child: Expanded(
//                     child: ListView.builder(
//                       padding: EdgeInsets.zero,
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: VideoModule.nameTECs.length,
//                       itemBuilder: (BuildContext context, int cIndex) {
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             QuestionTextField(index: cIndex),
//                             SizedBox(height: 5),
//                             _removeButton(cIndex),
//                             SizedBox(height: 15)
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: CustomElevatedButton(
//                     disable: widget.disable,
//                     title: 'Add another question',
//                     onTap: () {
//                       validateAndSave();
//
//                       // VideoModule.nameTECs.asMap().containsKey(index) ||
//                       if (!VideoModule.nameTECs.asMap().containsKey(index) ||
//                           VideoModule.nameTECs[index].text.isNotEmpty) {
//                         if (VideoModule.nameTECs.length <= 2 &&
//                             VideoModule.videoList.asMap().containsKey(index)) {
//                           VideoModule.nameTECs.add(TextEditingController());
//                           count++;
//                           friendsList.insert(0, '');
//                           index = index + 1;
//                           // VideoModule.indexes.add(count);
//                           setState(() {});
//                         } else {
//                           BotToast.showText(text: 'please add video');
//                         }
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 SizedBox(
//                   width: double.infinity,
//                   child: CustomElevatedButton(
//                     disable: widget.disable,
//                     title: 'Continue',
//                     onTap: () {
//                       publishVideo();
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   publishVideo() {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     VideoModule.videoQuestions.clear();
//     _formKey.currentState!.save();
//     List<String> questions = VideoModule.videoQuestions;
//
//     if (VideoModule.nameTECs[index].text.isEmpty) {
//       BotToast.showText(text: 'Please fill the question');
//       VideoModule.videoQuestions.clear();
//     } else if (VideoModule.videoList.isEmpty) {
//       BotToast.showText(text: 'Please record video');
//       VideoModule.videoQuestions.clear();
//     } else if (VideoModule.videoQuestions.length >
//         VideoModule.videoList.length) {
//       VideoModule.videoQuestions.clear();
//       BotToast.showText(text: 'Please record video');
//     } else if (VideoModule.videoQuestions.length <
//         VideoModule.videoList.length) {
//       VideoModule.videoQuestions.clear();
//       BotToast.showText(text: 'Please enter the question');
//     } else if (VideoModule.videoList.length ==
//         VideoModule.videoQuestions.length) {
//       NavRouter.push(context, UnrelatedQuestionScreen());
//     }
//   }
//
//   // List<Widget> _getFriends() {
//   //   List<Widget> friendsTextFields = [];
//   //   for (int i = 0; i < VideoModule.nameTECs.length; i++) {
//   //     friendsTextFields.add(Column(
//   //       mainAxisAlignment: MainAxisAlignment.start,
//   //       crossAxisAlignment: CrossAxisAlignment.center,
//   //       children: [
//   //         QuestionTextField(index: i),
//   //         SizedBox(height: 5),
//   //         _removeButton(i),
//   //         SizedBox(height: 15)
//   //       ],
//   //     ));
//   //   }
//   //   return friendsTextFields;
//   // }
//
//   // remove button
//   Widget _removeButton(int dataIndex) {
//     return InkWell(
//       onTap: () {
//         if (VideoModule.nameTECs.length == 1) {
//           VideoModule.nameTECs[dataIndex].text = '';
//           if (VideoModule.videoList.asMap().containsKey(dataIndex)) {
//             VideoModule.videoList.removeAt(dataIndex);
//           }
//           setState(() {});
//         }
//         if (VideoModule.nameTECs.length > 1) {
//           // friendsList.removeAt(index);
//           VideoModule.nameTECs.removeAt(dataIndex);
//           if (VideoModule.videoList.asMap().containsKey(dataIndex)) {
//             VideoModule.videoList.removeAt(dataIndex);
//           }
//           index = index - 1;
//           // VideoModule.nameTECs[index].clear();
//           // VideoModule.indexes.remove(count);
//           // VideoModule.videoQuestions.removeAt(index);
//           // VideoModule.indexes.removeAt(index);
//           setState(() {});
//         }
//       },
//       child: Padding(
//           padding: const EdgeInsets.only(bottom: 14.0, right: 16),
//           child: Icon(Icons.cancel, color: AppColors.black)),
//     );
//   }
// }
//
// class QuestionTextField extends StatefulWidget {
//   const QuestionTextField({
//     Key? key,
//     required this.index,
//   }) : super(key: key);
//   final int index;
//
//   @override
//   State<QuestionTextField> createState() => _QuestionTextFieldState();
// }
//
// class _QuestionTextFieldState extends State<QuestionTextField> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       child: Row(
//         children: [
//           Flexible(
//             child: CustomTextFormField(
//               validator: (v) {
//                 if (v!.trim().isEmpty)
//                   BotToast.showText(text: 'please enter question');
//                 return null;
//               },
//               controller: VideoModule.nameTECs[widget.index],
//               onSaved: (value) {
//                 VideoModule.videoQuestions.add(value!);
//               },
//               // onChanged: (v) => VideoModule.nameTECs[widget.index].text = v,
//               // onChanged: (v) {},
//               readOnly: true,
//               onTap: () {},
//               keyboardType: TextInputType.text,
//               labelText: 'Add question',
//               onPressSuffixIcon: () {},
//               isQuestionScreen: true,
//             ),
//           ),
//           SizedBox(width: 10),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 0.0),
//             child: GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: () {
//                 (!(VideoModule.videoList.asMap().containsKey(widget.index)) ||
//                         VideoModule.videoList[widget.index] == null)
//                     ? NavRouter.push(context, IdleVideoCameraScreen())
//                         .then((value) async {
//                         if (value != null) {
//                           VideoModule.videoList.add(value);
//                           VideoModule.videoList;
//                           setState(() {});
//                         }
//                       })
//                     : null;
//               },
//               child: Icon(
//                   (!(VideoModule.videoList.asMap().containsKey(widget.index)) ||
//                           VideoModule.videoList[widget.index] == null)
//                       ? (Icons.videocam)
//                       : (Icons.check),
//                   color: (!(VideoModule.videoList
//                               .asMap()
//                               .containsKey(widget.index)) ||
//                           VideoModule.videoList[widget.index] == null)
//                       ? AppColors.black
//                       : AppColors.success,
//                   size: 25),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
