import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/features/home/screens/home_screen.dart';
import 'package:helpert_app/features/notifications/model/notification_model.dart';
import 'package:helpert_app/features/video_call/model/call_model.dart';

import '../../../features/appointment/screens/appointment_detail_screen.dart';
import '../../../features/chat/screens/chat_screen.dart';
import '../../../features/new_video_upload/screens/flick_media_player_docs/short_video_home_page.dart';
import '../../../features/notifications/screens/notification_screen.dart';
import '../../../features/profile/screens/edit_profile_screen.dart';
import '../../../features/video/model/videos_model.dart';
import '../../../features/video/repo/video_repo.dart';
import '../../../features/video_call/bloc/home/home_cubit.dart';
import '../../../utils/nav_router.dart';
import 'local_notification_service.dart';

class CloudMessagingService {
  CloudMessagingService._privateConstructor();

  static final CloudMessagingService _instance =
      CloudMessagingService._privateConstructor();

  static CloudMessagingService get instance => _instance;

  /* ========================================================================================================*/

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void init() async {
    _handleOnMessage();
    _handleUserInteraction();

    if (Platform.isIOS) {
      _setForeGroundNotificationsIOS();
      _setNotificationPermissionsIOS();
    }
  }

  void _handleOnMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {}
      AndroidNotification? android = message.notification?.android;
      debugPrint(message.data['type']);
      LocalNotificationsService.instance.showNotification(message, android);
    });
  }

  Future<void> _handleUserInteraction() async {
    // from terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage, isFromTerminatedState: true);
    }
    // from background state
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message,
      {bool isFromTerminatedState = false}) async {
    int duration = isFromTerminatedState ? 4 : 0;
    Future.delayed(Duration(seconds: duration)).then((value) async {
      var data = message.data;
      if (data['type'] == 'newfollow' || data['type'] == 'unfollow') {
        NavRouter.to(NotificationScreen());
      }
      if (data['type'] == 'appointment') {
        NotificationModel notificationModel =
            NotificationModel.fromJson(json.decode(data['data']));

        await NavRouter.to(AppointmentDetailScreen(
          notificationId: notificationModel.notificationId,
          read: notificationModel.read,
          appointmentModel: notificationModel.appointmentDetail!,
          receiverId: notificationModel.senderId,
          userId: notificationModel.senderId,
        ));
      }

      if (data['type'] == 'incomplete_account' &&
          data['type'] == 'unset_availability') {
        NotificationModel notificationModel =
            NotificationModel.fromJson(json.decode(data['data']));
        NavRouter.to(EditProfileScreen(
          notificationId: notificationModel.notificationId,
          read: notificationModel.read,
          myScheduleNotification: true,
          addPaymentNotification: true,
        ));
      } else {
        if (data['type'] == 'incomplete_account') {
          debugPrint(data['type']);
          NotificationModel notificationModel =
              NotificationModel.fromJson(json.decode(data['data']));
          NavRouter.to(EditProfileScreen(
            notificationId: notificationModel.notificationId,
            read: notificationModel.read,
            myScheduleNotification: false,
            addPaymentNotification: true,
          ));
        } else if (data['type'] == 'unset_availability') {
          debugPrint(data['type']);
          NotificationModel notificationModel =
              NotificationModel.fromJson(json.decode(data['data']));
          NavRouter.to(EditProfileScreen(
            notificationId: notificationModel.notificationId,
            read: notificationModel.read,
            addPaymentNotification: false,
            myScheduleNotification: true,
          ));
        }
      }

      if (data['type'] == 'New Call' && duration != 0) {
        debugPrint(json.decode(data['data']));
        CallModel callModel = CallModel.fromJson(json.decode(data['data']));
        debugPrint('Model not null');
        debugPrint('${callModel.toMap()}');
        HomeCubit.get(NavRouter.navigationKey.currentState!.context)
            .emitStartCall(callModel: callModel, receiver: true);
      }

      if (data['type'] == 'deduct_payment') {
        debugPrint(json.decode(data['data']));
        CallModel callModel = CallModel.fromJson(json.decode(data['data']));
        debugPrint('Model not null');
        debugPrint('${callModel.toMap()}');
        NavRouter.to(HomeScreen());
      }

      if (data['type'] == 'deduct_payment') {
        NavRouter.to(HomeScreen());
      }

      if (data['type'] == 'new_video') {
        NotificationModel notificationModel =
            NotificationModel.fromJson(json.decode(data['data']));
        var formData = {
          'page': 0,
          'per_page': 10,
        };
        AllVideosModel result =
            await VideoRepo.instance.fetchAllVideosApi(formData);
        NavRouter.push(
            NavRouter.navigationKey.currentState!.context,
            (ShortVideoHomePage(
                videoBotId: notificationModel.videobot_id,
                route: 'video',
                listIndex: 0,
                videoList: result.videos_list)));
      }
      if (data['type'] == 'new_message') {
        NotificationModel notificationModel =
            NotificationModel.fromJson(json.decode(data['data']));
        print('Cloud service');
        print(notificationModel.toJson());

        NavRouter.push(
          NavRouter.navigationKey.currentState!.context,
          ChatScreen(
            name:
                '${notificationModel.firstName} ${notificationModel.lastName}',
            image: notificationModel.image,
            receiverId: notificationModel.senderId,
            speciality: notificationModel.specialization,
            timezone: notificationModel.timezone,
            sessionRate: notificationModel.sessionRate,
          ),
        );
      }
    });
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> deleteToken() async {
    _firebaseMessaging.deleteToken();
  }

  void _setForeGroundNotificationsIOS() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  void _setNotificationPermissionsIOS() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
