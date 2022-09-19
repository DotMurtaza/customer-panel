import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'app_bar_leading.dart';

class RoundedAppBar extends AppBar {
  final String? titleText;

  final Color bgColor;
  final Color textColor;
  final void Function()? onTap;
  bool isLeading;
  final ShapeBorder shapeBorder;

  final bool isBorder;
  final double borderRadius;

  final List<Widget>? actionButtons;

  RoundedAppBar({
    this.isLeading = false,
    this.isBorder = true,
    this.borderRadius = 15,
    this.titleText,
    this.textColor = Colors.white,
    this.bgColor = redColor,
    this.shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
    ),
    this.onTap,
    this.actionButtons,
    Key? key,
  }) : super(
          key: key,
          titleSpacing: 0,
          backgroundColor: bgColor,
          shape: shapeBorder,
          leading: isLeading
              ? AppbarLeading(isBorder: isBorder, borderRadius: borderRadius)
              : SizedBox(),
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
          title: titleText != null ? Text(titleText) : null,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: actionButtons,
        );
}
