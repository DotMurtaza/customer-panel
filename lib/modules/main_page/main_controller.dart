import 'dart:async';
import 'package:flutter/material.dart';

class MainController {
  static final MainController _singleton = MainController._internal();

  factory MainController() {
    return _singleton;
  }

  MainController._internal();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pageController = PageController();

  final naveListener = StreamController<int>.broadcast();
}
