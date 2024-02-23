import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/components/text_view.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../constants/app_colors.dart';
import 'bottons/elevated_button_without_icon.dart';

class CustomDialogs {
  // ====================================== Image Selection Dialog ======================================
  static Future<dynamic> showImageSelectionDialog(BuildContext context,
      {required Function() onSelectGallery,
      required Function() onSelectCamera}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Select Image"),
          children: [
            SimpleDialogOption(
              onPressed: onSelectCamera,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_rounded,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        'Pick from camera',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  )),
            ),
            SimpleDialogOption(
              onPressed: onSelectGallery,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      'Pick from gallery',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  static Future<dynamic> showLogoutDialog(BuildContext context,
      {required Function() onYesSelection, required Function() onNoSelection}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          titlePadding:
              EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
            child: TextView(
              "Are you sure, you want to logout?",
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
          children: [
            Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                          child: ElevatedButtonWithoutIcon(
                              primaryColor: AppColors.acmeBlue,
                              borderColor: AppColors.acmeBlue,
                              height: 38,
                              text: 'Yes',
                              onPressed: onYesSelection)),
                      SizedBox(width: 20),
                      Expanded(
                          child: ElevatedButtonWithoutIcon(
                              primaryColor: AppColors.pureWhite,
                              borderColor: AppColors.moon,
                              textColor: AppColors.failure,
                              height: 38,
                              text: 'No',
                              onPressed: onNoSelection)),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
              ],
            )
          ],
        );
      },
    );
  }

  static Future<dynamic> showDeleteDialog(BuildContext context,
      {required Function() deleteFunction,
      required Function() cancelFunction}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 110),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                GestureDetector(
                  onTap: deleteFunction,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.delete, size: 20, color: AppColors.failure),
                      SizedBox(width: 5),
                      Text("Delete",
                          style: TextStyles.regularTextStyle(
                              textColor: AppColors.failure)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: cancelFunction,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.close, size: 20, color: AppColors.acmeBlue),
                      SizedBox(width: 5),
                      Text("Cancel",
                          style: TextStyles.regularTextStyle(
                              textColor: AppColors.acmeBlue)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            )
          ],
        );
      },
    );
  }

  static showPaymentStatusNotificationDialog(BuildContext context,
      {required Function() onOkTap}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Container(
              margin: EdgeInsets.only(left: 0.0, right: 0.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: 18.0,
                    ),
                    margin: EdgeInsets.only(top: 13.0, right: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 0.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 20),
                          child: Text(
                              "Sorry! This Expert is not accepting appointment right now.  Will let you know",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.4,
                                  fontSize: 18.0,
                                  color: Color(0xFF666666))),
                        ) //
                            ),
                        SizedBox(height: 24.0),
                        Container(
                          height: 44,
                          margin:
                              EdgeInsets.only(bottom: 20, left: 85, right: 85),
                          child: ElevatedButtonWithoutIcon(
                              primaryColor: AppColors.acmeBlue,
                              borderColor: AppColors.acmeBlue,
                              height: 38,
                              text: 'Yes',
                              onPressed: onOkTap),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            NavRouter.pop(context);
                          },
                          iconSize: 30,
                          icon: Icon(Icons.close,
                              color: Color(0xFF2C3E50).withOpacity(1)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Future<dynamic> showDayNotAvailableDialog(
    BuildContext context,
    String message,
    String btnText, {
    required Function() onOkSelection,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          titlePadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.nickel,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconButton(
                      splashRadius: 24,
                      icon: Icon(Icons.close),
                      onPressed: () {
                        NavRouter.pop(context);
                      },
                    ),
                  ))
            ],
          ),
          children: [
            Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButtonWithoutIcon(
                            primaryColor: AppColors.acmeBlue,
                            borderColor: AppColors.acmeBlue,
                            height: 38,
                            text: btnText,
                            onPressed: onOkSelection),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  static Future<String> showDialogWithTextField(BuildContext context,
      String title, String hint, String buttonText) async {
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
                content: WillPopScope(
                  onWillPop: () {
                    value = '';
                    NavRouter.pop(context, '');
                    return Future.value(true);
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 300,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              title,
                              style: TextStyles.boldTextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 8,
                            ),
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
                                      border: InputBorder.none, hintText: hint),
                                ),
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if (!_formKey.currentState!.validate()) {
                                  BotToast.showText(
                                      text: 'please enter question');
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    NavRouter.pop(context, '');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.acmeBlue.withOpacity(.4),
                                    // fixedSize: Size(250, 50),
                                  ),
                                  child: Text(
                                    "Submit",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                      Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            splashRadius: 24,
                            icon: Icon(Icons.close),
                            onPressed: () {
                              value = '';
                              FocusScope.of(context).unfocus();
                              NavRouter.pop(context, '');
                            },
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 300),
        barrierDismissible: false,
        barrierLabel: '',
        pageBuilder: (context, animation1, animation2) {
          return SizedBox();
        });
    return value;
  }
}
