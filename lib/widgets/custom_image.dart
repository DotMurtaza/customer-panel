import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    Key? key,
    required this.path,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);
  final String path;
  final BoxFit fit;
  final double? height, width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (path.endsWith('.svg')) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(
          path,
          fit: fit,
          height: height,
          width: width,
          color: color,
        ),
      );
    }
    if (path.startsWith('http') ||
        path.startsWith('https') ||
        path.startsWith('www.')) {
      return Image.network(
        path,
        fit: fit,
        color: color,
        height: height,
        width: width,
      );
    }
    return Image.asset(
      path,
      fit: fit,
      color: color,
      height: height,
      width: width,
    );
  }
}
