import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/utils/nav_router.dart';

Future<String> showDataAlert(BuildContext context) async {
  String value = '';
  final _formKey = GlobalKey<FormState>();
  await showGeneralDialog(
      context: context,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.only(
                top: 10.0,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Write Script",
                    style: TextStyles.boldTextStyle(fontSize: 25),
                  ),
                  IconButton(
                      onPressed: () {
                        NavRouter.pop(context, value);
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              content: Container(
                height: 300,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'please enter question';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (v) {
                            value = v;
                          },
                          maxLines: 4,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  'Write answer if you need a script before making the video'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (!_formKey.currentState!.validate()) {
                          BotToast.showText(text: 'please enter question');
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            NavRouter.pop(context, '');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.acmeBlue.withOpacity(.4),
                            // fixedSize: Size(250, 50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "Submit",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Icon(Icons.videocam)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 600),
      barrierDismissible: false,
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) {
        return SizedBox();
      });
  return value;
}
