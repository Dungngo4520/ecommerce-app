import 'package:ecommerce/components/custom_bottom_navbar.dart';
import 'package:ecommerce/enum.dart';
import 'package:ecommerce/models/UserData.dart';
import 'package:ecommerce/screens/profile/components/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static String route = '/profile';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user.name),
        leading: SizedBox(),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.profile,
      ),
    );
  }
}
