import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/core/multi_bloc_providers.dart';
import 'package:helpert_app/splash_screen.dart';
import 'package:helpert_app/utils/nav_router.dart';
import 'package:helpert_app/utils/theme/dark_theme.dart';

import 'app_init.dart';
import 'constants/asset_paths.dart';

late List<CameraDescription> cameras;

void main() async {
  await appInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(helpert_logo_square_png), context);
    return MultiBlocProvider(
      providers: multiBlocProviders(),
      child: MaterialApp(
        navigatorKey: NavRouter.navigationKey,
        builder: BotToastInit(),
        navigatorObservers: [
          BotToastNavigatorObserver(),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Helpert App',
        theme: lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
