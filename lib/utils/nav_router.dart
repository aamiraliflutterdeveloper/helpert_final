import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavRouter {
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> to(Widget page, {arguments}) async =>
      navigationKey.currentState?.push(MaterialPageRoute(
        builder: (_) => page,
      ));

  /*  PUSH  */
  static Future push(BuildContext context, Widget route) {
    return Navigator.push(context, CupertinoPageRoute(builder: (_) => route));
  }

  /*  PUSH REPLACEMENT  */
  static Future pushReplacement(BuildContext context, Widget route) {
    return Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => route,
      ),
    );
  }

  /* PUSH AND REMOVE UNTIL */
  static Future pushAndRemoveUntil(BuildContext context, Widget route) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => route,
        ),
        (Route<dynamic> route) => false);
  }

  static void pop(BuildContext context, [data]) {
    return Navigator.of(context).pop(data);
  }

  static void pushToRoot(BuildContext context) {
    return Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
