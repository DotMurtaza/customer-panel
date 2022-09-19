import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../router_name.dart';
import '../../../utils/constants.dart';
import '../model/chat_list_model.dart';

class SingleChatListItem extends StatelessWidget {
  const SingleChatListItem({
    Key? key,
    required this.item,
    this.isLastItem = false,
  }) : super(key: key);
  final ChatListModel item;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.messageScreen);
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 16, top: 16),
        decoration: BoxDecoration(
          border: isLastItem
              ? null
              : const Border(
                  bottom: BorderSide(color: borderColor, width: 1),
                ),
        ),
        child: Row(
          children: [
            const CircleAvatar(radius: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.msg,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: inputColor),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildNumberOfMessage(item.numberOfMsg),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Text(
                    item.dateTime,
                    style: const TextStyle(color: inputColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNumberOfMessage(String s) {
    if (s.isEmpty) {
      return Container(
        width: 20,
        margin: const EdgeInsets.only(left: 16),
        height: 20,
      );
    }
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: redColor,
      ),
      child: Center(
        child: Text(
          item.numberOfMsg,
          style: const TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
