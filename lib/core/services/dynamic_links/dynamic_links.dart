import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../features/new_video_upload/screens/flick_media_player_docs/short_video_home_page.dart';
import '../../../features/video/model/videos_model.dart';
import '../../../features/video/repo/video_repo.dart';

class DynamicLinks {
  DynamicLinks._privateConstructor();

  static final DynamicLinks _instance = DynamicLinks._privateConstructor();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  static DynamicLinks get instance => _instance;

  config() async {
    await createDynamicLink(true);
    await handleDynamicLinks();
  }

  Future handleDynamicLinks() async {
    //Get initial dynamic link if app is starting using the dynamic link
    PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (data != null) {
      _handleDeepLink(data);
    }

    //Into foreground
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _handleDeepLink(dynamicLinkData);
    }).onError((error) {
      debugPrint("error $error");
    });
  }

  Future<void> _handleDeepLink(PendingDynamicLinkData data) async {
    Future.delayed(Duration(seconds: 3), () async {
      final Uri? deepLink = data.link;

      if (deepLink != null) {
        if (deepLink.queryParameters['id'] != null) {
          int videoId = int.parse(deepLink.queryParameters['id']!);
          try {
            var data = {
              'page': 0,
              'per_page': 10,
            };
            AllVideosModel result =
                await VideoRepo.instance.fetchAllVideosApi(data);
            if (result.videos_list.isNotEmpty) {
              NavRouter.push(
                  NavRouter.navigationKey.currentState!.context,
                  (ShortVideoHomePage(
                      videoBotId: videoId,
                      route: 'home',
                      listIndex: 0,
                      videoList: result.videos_list)));
            }
          } catch (e) {
            debugPrint('exception is :: $e');
          }
        }
      }
    });
  }

  Future<Uri> createDynamicLink(bool short) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://helpertapp.page.link',
      link: Uri.parse('https://helpertapp.page.link/returnUrl'),
      androidParameters: const AndroidParameters(
        packageName: 'com.cas.helpert_app',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.cas.helpert_app',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      try {
        final ShortDynamicLink shortLink =
            await dynamicLinks.buildShortLink(parameters);
        url = shortLink.shortUrl;
      } catch (e) {
        url = Uri();
        debugPrint('Exception in dynamic links $e');
      }
    } else {
      try {
        url = await dynamicLinks.buildLink(parameters);
      } catch (e) {
        url = Uri();
        debugPrint('Exception in dynamic links $e');
      }
    }
    return url;
  }
}
