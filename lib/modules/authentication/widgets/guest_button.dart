import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../router_name.dart';

class GuestButton extends StatelessWidget {
  const GuestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.mainPage, (route) => false);
      },
      child: Text(
        'Continue as Guest',
        style: GoogleFonts.roboto(
            fontSize: 16,
            decoration: TextDecoration.underline,
            color: Colors.blue,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
