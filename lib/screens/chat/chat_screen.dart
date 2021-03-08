import 'package:ecommerce/components/custom_bottom_navbar.dart';
import 'package:ecommerce/enum.dart';
import 'package:ecommerce/screens/chat/component/body.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static String route = '/chat';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.message),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
    );
  }
}
