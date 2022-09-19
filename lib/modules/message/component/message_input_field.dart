import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class MessageInputField extends StatefulWidget {
  const MessageInputField({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final editingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    editingController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: Container(
          color: const Color(0xfff6f6f6),
          child: Row(
            children: [
              Container(
                height: 34,
                width: 34,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: redColor,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              Flexible(
                child: TextField(
                  focusNode: focusNode,
                  textInputAction: TextInputAction.done,
                  controller: editingController,
                  decoration: inputDecorationTheme.copyWith(
                    hintText: 'Message ...',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    suffixIcon: const Icon(Icons.emoji_emotions,
                        color: iconGreyColor, size: 22),
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
