import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFFffff);
const Color blackColor = Color(0xff0B2C3D);
const Color secondaryColor = Color(0xff2E2E2E);
const Color borderColor = Color(0xFFD9D9D9);
const Color unselectIndicatorColor = Color(0xFFDAECFF);
const Color greenColor = Color(0xFF34A853);
const Color grayColor = Color(0xff7C808A);
const Color redColor = Color(0xffF54748);
const Color favColor = Color(0xffFE0012);
const Color iconGreyColor = Color(0xff85959E);
const Color paragraphColor = Color(0xff4F5562);
const Color inputFieldFillColor = Color(0xffFFFAF7);
const Color inputColor = Color(0xff8B8F97);
const greenGredient = [redColor, redColor];

// #duration
const kDuration = Duration(milliseconds: 300);

final _borderRadius = BorderRadius.circular(4);

var inputDecorationTheme = InputDecoration(
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  hintStyle: const TextStyle(fontSize: 18, height: 1.667),
  border: OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: const BorderSide(color: Colors.white),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: const BorderSide(color: Colors.white),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: const BorderSide(color: Colors.white),
  ),
  fillColor: inputFieldFillColor,
  filled: true,
  focusColor: primaryColor,
);

final gredientColors = [
  [const Color(0xffF6290C), const Color(0xffC70F16)],
  [const Color(0xff019BFE), const Color(0xff0077C1)],
  [const Color(0xff161632), const Color(0xff3D364E)],
  [const Color(0xffF6290C), const Color(0xffC70F16)],
  [const Color(0xff019BFE), const Color(0xff0077C1)],
  [const Color(0xff161632), const Color(0xff3D364E)],
];
