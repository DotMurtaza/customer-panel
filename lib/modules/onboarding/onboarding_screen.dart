import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../router_name.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_image.dart';
import 'model/onboarding_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = onBoardingList.length;
  final _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: kDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: isActive ? redColor : unselectIndicatorColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget getContent() {
    final item = onBoardingList[_currentPage];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: ValueKey('$_currentPage'),
      children: [
        FittedBox(
          child: Text(
            item.title,
            style:
                GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: 15),
        Text(item.paragraph,
            style: TextStyle(fontSize: 16, color: blackColor.withOpacity(.5))),
      ],
    );
  }

  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[_buildImagesSlider(), _buildBottomContent()],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: kDuration,
            transitionBuilder: (Widget child, Animation<double> anim) {
              return FadeTransition(opacity: anim, child: child);
            },
            child: getContent(),
          ),
          const SizedBox(height: 25),
          _buildBottomButtonIndicator(),
        ],
      ),
    );
  }

  Widget _buildBottomButtonIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
            minimumSize: const Size(80, 80),
            backgroundColor: redColor,
            shape: const CircleBorder(),
          ),
          onPressed: () {
            if (_currentPage == _numPages - 1) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.signInScreen, (route) => false);
              return;
            }
            _pageController.nextPage(
                duration: kDuration, curve: Curves.easeInOut);
          },
          child: const Center(child: Text("Next")),
        ),
      ],
    );
  }

  Widget _buildImagesSlider() {
    return SizedBox(
      height: size.height / 2.57,
      child: PageView(
        physics: const ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: onBoardingList
            .map(
              (e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomImage(path: e.image)),
            )
            .toList(),
      ),
    );
  }
}
