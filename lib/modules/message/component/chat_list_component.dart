import 'package:flutter/material.dart';

import '../model/chat_list_model.dart';
import 'single_chat_list_item.dart';

class ChatListComponent extends StatelessWidget {
  const ChatListComponent({
    Key? key,
    required this.chatList,
  }) : super(key: key);
  final List<ChatListModel> chatList;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return SingleChatListItem(
              item: chatList[index],
              isLastItem: index == chatList.length - 1,
            );
          },
          childCount: chatList.length,
        ),
      ),
    );
  }
}
