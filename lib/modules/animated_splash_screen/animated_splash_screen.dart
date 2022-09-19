import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/map_screen.dart';
import 'package:foodbari_deliver_app/root.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../widgets/custom_image.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  Future startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // Get.offAll(() => MapScreen());
    Get.offAll(() => RootCustomer());
    // Navigator.of(context).pushReplacementNamed(RouteNames.signInScreen);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _init();

    animation.addListener(() {
      if (mounted) setState(() {});
      if (animationController.isCompleted) {
        animationController.repeat();
      }
    });

    animationController.forward();

    startTime();
  }

  void _init() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [redColor, redColor],
              ),
            ),
            child: Stack(
              children: [
                const SizedBox(),
                Positioned(
                  left: size.width * 0.4,
                  top: 0,
                  child: SafeArea(
                    child: CircleAvatar(
                      radius: 280,
                      backgroundColor: Colors.white.withOpacity(0.09),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: -25,
                  child: SafeArea(
                    child: CircleAvatar(
                      radius: 280,
                      backgroundColor: Colors.white.withOpacity(0.09),
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const SizedBox(width: double.infinity),
              Center(
                child: CustomImage(
                  path: Kimages.logoColor,
                  width: animation.value * 260,
                  height: animation.value * 260,
                  // height:  max((animation.value * 260), 100),
                ),
              ),
              // const SizedBox(height: 20),
              // Center(
              //   child: Text(
              //     Kstrings.appName,
              //     style: GoogleFonts.roboto(
              //       fontSize: 50,
              //       height: 1,
              //       color: Colors.white,
              //       fontWeight: FontWeight.w900,
              //     ),
              //   ),
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //       height: 4,
              //       width: 50,
              //       margin: const EdgeInsets.only(right: 4),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(4),
              //       ),
              //     ),
              //     Text(
              //       'Delivery Man',
              //       style: GoogleFonts.roboto(
              //         fontSize: 30,
              //         height: 1,
              //         color: Colors.white,
              //         fontWeight: FontWeight.w900,
              //       ),
              //     ),
              //     const SizedBox(width: 30),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
