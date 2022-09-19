import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _applyShadow(
          child: GoogleAuthButton(
            onPressed: () {},
            darkMode: false,
            style: const AuthButtonStyle(
                buttonType: AuthButtonType.icon,
                elevation: 0,
                iconSize: 18,
                height: 40,
                width: 40
                // iconType: AuthIconType.secondary,
                ),
          ),
        ),
        const SizedBox(width: 15),
        _applyShadow(
          child: FacebookAuthButton(
            onPressed: () {},
            darkMode: false,
            style: const AuthButtonStyle(
                buttonType: AuthButtonType.icon,
                buttonColor: Colors.white,
                iconColor: Colors.blue,
                elevation: 0,
                iconSize: 18,
                height: 40,
                width: 40
                // iconType: AuthIconType.secondary,
                ),
          ),
        ),
        const SizedBox(width: 15),
        _applyShadow(
          child: AppleAuthButton(
            onPressed: () {},
            darkMode: false,
            style: const AuthButtonStyle(
                buttonType: AuthButtonType.icon,
                elevation: 0,
                iconSize: 18,
                height: 40,
                width: 40
                // iconType: AuthIconType.secondary,
                ),
          ),
        ),
      ],
    );
  }

  Widget _applyShadow({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.13),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
