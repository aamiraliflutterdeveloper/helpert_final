import 'package:flutter/material.dart';

class TabBarDecoration extends StatelessWidget {
  const TabBarDecoration(
      {Key? key, required this.tabBar, required this.decoration}) : super(key: key);

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          decoration: decoration,
          margin: const EdgeInsets.only(bottom: .5),
        )),
        tabBar,
      ],
    );
  }
}
