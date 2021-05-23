import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/ChatMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: cPrimaryColor.withOpacity(message.senderId == user.uid ? 1 : 0.1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(message.senderId == user.uid ? 20 : 7),
          bottomRight: Radius.circular(message.senderId == user.uid ? 7 : 20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Text(
        message.content,
        style: TextStyle(
          color: message.senderId == user.uid ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
