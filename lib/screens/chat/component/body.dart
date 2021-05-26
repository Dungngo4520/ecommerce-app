import 'package:ecommerce/models/ChatRoom.dart';
import 'package:ecommerce/screens/chat/component/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ChatRoom> chatRoomList = Provider.of<List<ChatRoom>>(context);
    if (chatRoomList.isNotEmpty) {
      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: chatRoomList.length,
              itemBuilder: (context, index) => ChatCard(chatroom: chatRoomList[index]),
              separatorBuilder: (context, index) => Divider(height: 1),
            ),
          ),
        ],
      );
    }
    return Center(
      child: Text(
        '¯ \\_(ツ)_/¯',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
