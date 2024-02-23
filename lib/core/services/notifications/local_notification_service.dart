import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helpert_app/features/appointment/screens/appointment_detail_screen.dart';
import 'package:helpert_app/features/notifications/model/notification_model.dart';
import 'package:helpert_app/features/notifications/screens/notification_screen.dart';
import 'package:helpert_app/features/profile/screens/edit_profile_screen.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../features/chat/screens/chat_screen.dart';
import '../../../features/home/screens/home_screen.dart';
import '../../../features/new_video_upload/screens/flick_media_player_docs/short_video_home_page.dart';
import '../../../features/video/model/videos_model.dart';
import '../../../features/video/repo/video_repo.dart';

class LocalNotificationsService {
  LocalNotificationsService._privateConstructor();

  static final LocalNotificationsService _instance =
      LocalNotificationsService._privateConstructor();

  // Singleton instance across the app
  static LocalNotificationsService get instance => _instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  init() {
    _createChannel();
    _initSetting();
  }

  /* ===================================== Show notification ===================================== */

  // Future<void> showNotification(
  //     RemoteMessage remoteMessage, AndroidNotification? android) async {
  //   const int maxProgress = 5;
  //   for (int i = 0; i <= maxProgress; i++) {
  //     await Future<void>.delayed(const Duration(seconds: 1), () async {
  //       RemoteNotification? notification = remoteMessage.notification;
  //       if (notification != null && android != null) {
  //         _flutterLocalNotificationsPlugin.show(
  //             notification.hashCode,
  //             notification.title,
  //             notification.body,
  //             NotificationDetails(
  //               android: AndroidNotificationDetails(
  //                 _channel.id,
  //                 _channel.name,
  //                 channelDescription: _channel.description,
  //                 icon: android.smallIcon,
  //                 importance: Importance.max,
  //                 priority: Priority.high,
  //                 onlyAlertOnce: true,
  //                 showProgress: true,
  //                 maxProgress: maxProgress,
  //                 progress: i,
  //                 // other properties...
  //               ),
  //             ),
  //             payload: jsonEncode(remoteMessage.data));
  //       }
  //     });
  //   }
  // }

  void showNotification(
      RemoteMessage remoteMessage, AndroidNotification? android) {
    RemoteNotification? notification = remoteMessage.notification;
    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              icon: android.smallIcon,
            ),
          ),
          payload: jsonEncode(remoteMessage.data));
    }
  }

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> showProgressNotification(
      {required double value, required String title}) async {
    const double maxProgress = 100.0;

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'videoChannel', 'videoChannel Notifications',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true,
      // showProgress: a < 100 ? true : false,
      maxProgress: maxProgress.toInt(),
      autoCancel: true,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, '', platformChannelSpecifics, payload: 'item x');
    // if (value == 100.0) {
    //   await removeNotification(0);
    // }
    // if (a == 100) {
    //   print("this is 100% video compressing");
    // }
  }

  Future<void> showVideoUploading(
      {required double value, required String title}) async {
    const double maxProgress = 100.0;
    for (int a = 0; a <= maxProgress; a++) {
      a = a + value.toInt();
      await Future<void>.delayed(const Duration(milliseconds: 200), () async {
        final AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'videoUploading', 'videoUploading Notifications',
          channelShowBadge: false,
          importance: Importance.max,
          priority: Priority.high,
          onlyAlertOnce: true,
          // showProgress: a < 100 ? true : false,
          maxProgress: maxProgress.toInt(),
          autoCancel: true,
        );
        final NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(1,
            a >= 100 ? 'Video Uploaded' : title, '', platformChannelSpecifics,
            payload: 'item x');
        debugPrint('progress: ${(value / 100).toStringAsFixed(0)}% ($value)');

        Future.delayed(Duration(seconds: 1));
        if (a >= 100.0) {
          await removeNotification(1);
        }
      });
    }
  }

  /* ===================================== On select notification ===================================== */
  _selectNotification(NotificationResponse response) async {
    var data = json.decode(response.payload!);

    if (data['type'] == 'newfollow' || data['type'] == 'unfollow') {
      NavRouter.to(NotificationScreen());
    }

    if (data['type'] == 'appointment') {
      NotificationModel notificationModel =
          NotificationModel.fromJson(json.decode(data['data']));
      print('Local service');
      print(notificationModel.toJson());
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
        NotificationModel notificationModel =
            NotificationModel.fromJson(json.decode(data['data']));
        NavRouter.to(EditProfileScreen(
          notificationId: notificationModel.notificationId,
          read: notificationModel.read,
          myScheduleNotification: false,
          addPaymentNotification: true,
        ));
      } else if (data['type'] == 'unset_availability') {
        NotificationModel notificationModel =
            NotificationModel.fromJson(json.decode(data['data']));
        NavRouter.to(EditProfileScreen(
          notificationId: notificationModel.notificationId,
          read: notificationModel.read,
          addPaymentNotification: false,
          myScheduleNotification: true,
        ));
      }

      if (data['type'] == 'deduct_payment') {
        NavRouter.to(HomeScreen());
      }

      if (data['type'] == 'new_video') {
        Future.delayed(Duration(seconds: 3), () async {
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
        });
      }

      if (data['type'] == 'new_message') {
        NotificationModel notificationModel =
            NotificationModel.fromJson(json.decode(data['data']));
        print('Local service');
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
    }
  }

  /* ===================================== Remove notification ===================================== */
  Future removeNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /* ============================= Initialize Settings for android and ios ============================= */
  void _initSetting() async {
    // Android setting
    // const AndroidInitializationSettings initializationSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // IOS setting
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    // Init setting
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _selectNotification,
    );
  }

  /* ===================== Notification channel to override the default behaviour ===================== */
  final AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // name
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  void _createChannel() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  /* ===================================== For Older IOS versions ===================================== */
  Future _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }
}
