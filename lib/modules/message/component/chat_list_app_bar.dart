import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ChatListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const ChatListAppBar({Key? key, this.height = 82}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topStatusBar = MediaQuery.of(context).padding.top;
    return Material(
      color: Colors.white,
      child: SizedBox(
        height: height + topStatusBar,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: height + topStatusBar - 23,
              decoration: BoxDecoration(
                color: redColor,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff333333).withOpacity(.18),
                      blurRadius: 70),
                ],
              ),
            ),
            Positioned(
              bottom: 43,
              left: 40,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white.withOpacity(.09),
              ),
            ),
            Positioned(
              bottom: 23,
              left: -21,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white.withOpacity(.09),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff333333).withOpacity(.18),
                        blurRadius: 70),
                  ],
                ),
                child: TextFormField(
                  decoration: inputDecorationTheme.copyWith(
                    prefixIcon: const Icon(Icons.search, size: 26),
                    hintText: 'Search Name...',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 11,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
