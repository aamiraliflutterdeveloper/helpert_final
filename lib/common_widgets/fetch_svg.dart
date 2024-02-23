import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  const SvgImage(
      {Key? key,
      required this.path,
      this.width,
      this.height,
      this.color,
      this.fit = BoxFit.contain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      alignment: Alignment.bottomCenter,
      height: height,
      width: width,
      color: color,
      fit: fit!,
    );
  }
}

class SvgImageBottomIcon extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final Color? color;

  const SvgImageBottomIcon(
      {Key? key, required this.path, this.width, this.height, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      alignment: Alignment.bottomCenter,
      height: height,
      width: width,
      color: color,
    );
  }
}
