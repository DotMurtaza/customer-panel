import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../model/message_model.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({
    Key? key,
    required this.element,
  }) : super(key: key);
  final MessageModel element;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: BubbleNormal(
        text: element.text,
        isSender: element.isMe,
        sent: true,
        delivered: true,
        seen: true,
        color:
            element.isMe ? redColor : const Color(0xff18587A).withOpacity(.1),
        tail: true,
        textStyle: TextStyle(
          fontSize: 18,
          color: element.isMe ? Colors.white : blackColor,
        ),
      ),
    );
  }
}
