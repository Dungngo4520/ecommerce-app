import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/ChatRoom.dart';
import 'package:ecommerce/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatInputField extends StatefulWidget {
  final ChatRoom chatRoom;
  const ChatInputField({
    Key? key,
    required this.chatRoom,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController messageContent = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<DatabaseMethods>(context);
    final user = Provider.of<User>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Color(0xff087949).withOpacity(0.15),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageContent,
                decoration: InputDecoration(
                  hintText: "Type message",
                  border: InputBorder.none,
                ),
                onEditingComplete: () {
                  if (messageContent.text != "") {
                    firestore.addChatMessage(widget.chatRoom.id, messageContent.text, user.uid);
                  }
                  messageContent.clear();
                },
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.send_rounded,
                color: cPrimaryColor,
                size: 30,
              ),
              onPressed: () {
                if (messageContent.text != "") {
                  firestore.addChatMessage(widget.chatRoom.id, messageContent.text, user.uid);
                }
                messageContent.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}
