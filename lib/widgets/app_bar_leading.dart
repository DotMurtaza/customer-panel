import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AppbarLeading extends StatelessWidget {
  const AppbarLeading({
    Key? key,
    this.isBorder = false,
    this.borderRadius = 15,
  }) : super(key: key);

  final bool isBorder;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            border:
                isBorder ? Border.all(color: const Color(0xffB0D8FF)) : null,
          ),
          child: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new,
            color: blackColor,
          ),
        ),
      ),
    );
  }
}
