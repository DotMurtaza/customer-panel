import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class InVoiceWidget extends StatelessWidget {
  const InVoiceWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xffFEECEC),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          "Invoice : " + text,
          style: const TextStyle(color: redColor),
        ),
      ),
    );
  }
}
