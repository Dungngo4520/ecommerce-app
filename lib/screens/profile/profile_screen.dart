import 'package:ecommerce/components/custom_bottom_navbar.dart';
import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/constants.dart';
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
    return user.id.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                user.name
                    .toLowerCase()
                    .split(' ')
                    .map((x) => x[0].toUpperCase() + x.substring(1))
                    .join(' '),
                style: TextStyle(color: cTextColor, fontWeight: FontWeight.w600),
              ),
              leading: SizedBox(),
            ),
            body: Body(),
            bottomNavigationBar: CustomBottomNavBar(
              selectedMenu: MenuState.profile,
            ),
          )
        : LoadingScreen();
  }
}
