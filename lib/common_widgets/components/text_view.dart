import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView(
    this.text, {
    Key? key,
    required this.textStyle,
    this.textAlign,
  }) : super(key: key);
  final String text;
  final TextStyle textStyle;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: textAlign, style: textStyle);
  }
}
