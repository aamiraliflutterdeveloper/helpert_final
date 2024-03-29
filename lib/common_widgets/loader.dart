import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key, this.size = 28, this.value}) : super(key: key);
  final double size;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? SizedBox(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                color: Colors.blue,
                backgroundColor: Colors.white,
                strokeWidth: 3,
                value: value,
              ))
          : CupertinoActivityIndicator(),
    );
  }
}
