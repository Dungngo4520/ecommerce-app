import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/ChatRoom.dart';
import 'package:ecommerce/models/UserData.dart';
import 'package:ecommerce/screens/messages/messages_screen.dart';
import 'package:ecommerce/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chatroom,
  }) : super(key: key);

  final ChatRoom chatroom;

  String findChatUserId(List<String> list, String myId) {
    return list.where((element) => !element.contains(myId)).first;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final firestore = Provider.of<DatabaseMethods>(context);
    return StreamBuilder<UserData>(
      stream: Stream.fromFuture(firestore.getUserById(findChatUserId(chatroom.users, user.uid))),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListTile(
            dense: true,
            leading: CircleAvatar(
              backgroundColor: Colors.black.withAlpha(20),
              child: ClipOval(
                child: Image.network(
                  snapshot.data!.photoURL,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: cPrimaryColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            title: Text(
              snapshot.data!.name,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatroom.lastMessage,
                  overflow: TextOverflow.ellipsis,
                ),
                // ignore: unnecessary_null_comparison
                Text(timeago.format(chatroom.lastMessageTimestamp != null
                    ? (chatroom.lastMessageTimestamp.toDate())
                    : DateTime.now())),
              ],
            ),
            isThreeLine: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesScreen(
                    userData: snapshot.data!,
                    chatRoom: chatroom,
                  ),
                ),
              );
            },
          );
        }
        return LoadingScreen();
      },
    );
  }
}
