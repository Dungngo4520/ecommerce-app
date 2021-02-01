import 'package:ecommerce/screens/profile/components/profile_menu.dart';
import 'package:ecommerce/screens/profile/components/profile_picture.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfilePicture(),
          SizedBox(height: 20),
          ProfileMenu(
            text: 'My Account',
            icon: 'assets/icons/User Icon.svg',
            onPressed: () {},
          ),
          ProfileMenu(
            text: 'My Order',
            icon: 'assets/icons/Cart Icon.svg',
            onPressed: () {},
          ),
          ProfileMenu(
            text: 'Notifications',
            icon: 'assets/icons/Bell.svg',
            onPressed: () {},
          ),
          ProfileMenu(
            text: 'Settings',
            icon: 'assets/icons/Settings.svg',
            onPressed: () {},
          ),
          ProfileMenu(
            text: 'Help Center',
            icon: 'assets/icons/Question mark.svg',
            onPressed: () {},
          ),
          ProfileMenu(
            text: 'Log Out',
            icon: 'assets/icons/Log out.svg',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
