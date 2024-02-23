import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/main.dart';

import 'core/services/dynamic_links/dynamic_links.dart';
import 'core/services/notifications/cloud_messaging_service.dart';
import 'core/services/notifications/local_notification_service.dart';
import 'utils/shared_preference_manager.dart';

Future appInit() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await PreferenceManager.instance.init();
  await DynamicLinks.instance.config();
  //
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  //
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  CloudMessagingService.instance.init();
  LocalNotificationsService.instance.init();

  String? deviceToken = await CloudMessagingService.instance.getToken();
  log('fcm device token :: $deviceToken');
  try {
    cameras = await availableCameras();
  } on CameraException {
    debugPrint('Camera exception.');
  }
  assetsAssertion();
}

assetsAssertion() {
  precachePicture(
    ExactAssetPicture(
        SvgPicture.svgStringDecoderOutsideViewBoxBuilder, congrats_image),
    null,
  );
  // DynamicLinks.instance.config();
}
