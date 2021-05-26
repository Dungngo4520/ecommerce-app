import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/models/ChatMessage.dart';
import 'package:ecommerce/models/ChatRoom.dart';
import 'package:ecommerce/models/UserData.dart';
import 'package:ecommerce/screens/messages/components/chat_input_field.dart';
import 'package:ecommerce/screens/messages/components/message.dart';
import 'package:ecommerce/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final ChatRoom chatRoom;
  final UserData chatUser;
  const Body({
    Key? key,
    required this.chatRoom,
    required this.chatUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<DatabaseMethods>(context);
    return StreamBuilder<List<ChatMessage>>(
        stream: firestore.getMessage(chatRoom.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Message(
                        message: snapshot.data![index],
                        chatUser: chatUser,
                      ),
                    ),
                  ),
                ),
                ChatInputField(chatRoom: chatRoom),
              ],
            );
          }
          return LoadingScreen();
        });
  }
}
