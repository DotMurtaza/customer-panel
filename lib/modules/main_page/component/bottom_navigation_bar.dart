import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = MainController();
    return Material(
      elevation: 9,
      color: const Color(0x00ffffff),
      shadowColor: blackColor,
      child: StreamBuilder(
        initialData: 0,
        stream: _controller.naveListener.stream,
        builder: (_, AsyncSnapshot<int> index) {
          int _selectedIndex = index.data ?? 0;
          return Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BottomNavigationItem(
                  selectedIndex: _selectedIndex == 0,
                  icon: Kimages.homeIcon,
                  text: 'My Delivey',
                  index: 0,
                  onTap: (int index) {
                    _controller.naveListener.sink.add(index);
                  },
                ),
                // _BottomNavigationItem(
                //   selectedIndex: _selectedIndex == 1,
                //   icon: Kimages.inboxIcon,
                //   text: 'Inbox',
                //   index: 1,
                //   onTap: (int index) {
                //     _controller.naveListener.sink.add(index);
                //   },
                // ),
                _BottomNavigationItem(
                  selectedIndex: _selectedIndex == 1,
                  icon: Kimages.orderIcon,
                  text: 'New Request',
                  index: 1,
                  onTap: (int index) {
                    _controller.naveListener.sink.add(index);
                  },
                ),
                _BottomNavigationItem(
                  selectedIndex: _selectedIndex == 2,
                  icon: Kimages.profileIcon,
                  text: 'Profile',
                  index: 2,
                  onTap: (int index) {
                    _controller.naveListener.sink.add(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  const _BottomNavigationItem({
    Key? key,
    required this.selectedIndex,
    required this.icon,
    required this.text,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final bool selectedIndex;
  final String icon;
  final int index;
  final String text;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: selectedIndex ? secondaryColor.withOpacity(.1) : null,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: SvgPicture.asset(icon,
                  color: selectedIndex ? redColor : paragraphColor),
            ),
          ),
          Text(
            text,
            style: TextStyle(
                color: selectedIndex ? redColor : const Color(0xff85959E)),
          )
        ],
      ),
    );
  }
}
