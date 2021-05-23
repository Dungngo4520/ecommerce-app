import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/ChatRoom.dart';
import 'package:ecommerce/models/UserData.dart';
import 'package:ecommerce/screens/messages/components/body.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessagesScreen extends StatelessWidget {
  static String route = '/messages';
  final UserData userData;
  final ChatRoom chatRoom;

  const MessagesScreen({
    Key? key,
    required this.userData,
    required this.chatRoom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(),
            CircleAvatar(
              backgroundColor: Colors.black.withAlpha(20),
              child: ClipOval(
                child: Image.network(
                  userData.photoURL,
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
            SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData.name,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    timeago.format(chatRoom.lastMessageTimestamp.toDate()),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Body(
        chatRoom: chatRoom,
        chatUser: userData,
      ),
    );
  }
}
