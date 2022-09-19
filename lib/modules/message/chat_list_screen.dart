import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../dummy_data/all_dymmy_data.dart';
import 'component/chat_list_app_bar.dart';
import 'component/chat_list_component.dart';
import 'component/empty_chat_list_component.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 75;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: appBarHeight,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Color(0x00000000)),
            flexibleSpace: ChatListAppBar(height: appBarHeight),
          ),
          chatList.isEmpty
              ? const EmptyChatListComponent()
              : ChatListComponent(chatList: chatList),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
