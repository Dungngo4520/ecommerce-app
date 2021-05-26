import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/ChatMessage.dart';
import 'package:ecommerce/models/UserData.dart';
import 'package:ecommerce/screens/messages/components/text_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
    required this.chatUser,
  }) : super(key: key);

  final ChatMessage message;
  final UserData chatUser;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment:
            message.senderId == user.uid ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (message.senderId != user.uid) ...[
            CircleAvatar(
              backgroundColor: Colors.black.withAlpha(20),
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  chatUser.photoURL,
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
          ],
          SizedBox(width: 10),
          TextMessage(message: message),
        ],
      ),
    );
  }
}
