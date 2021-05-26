import 'package:ecommerce/screens/my_account/my_account_screen.dart';
import 'package:ecommerce/screens/profile/components/profile_menu.dart';
import 'package:ecommerce/screens/profile/components/profile_picture.dart';
import 'package:ecommerce/screens/seller_products/seller_products_screen.dart';
import 'package:ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthMethods>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfilePicture(changeable: false),
          SizedBox(height: 20),
          ProfileMenu(
            text: 'My Account',
            icon: 'assets/icons/User Icon.svg',
            onPressed: () {
              Navigator.pushNamed(context, MyAccountScreen.route);
            },
          ),
          ProfileMenu(
            text: 'My Order',
            icon: 'assets/icons/Cart Icon.svg',
            onPressed: () {},
          ),
          ProfileMenu(
            text: 'My Shop',
            icon: 'assets/icons/Shop Icon.svg',
            onPressed: () => Navigator.pushNamed(context, SellerProductsScreen.route),
          ),
          ProfileMenu(
            text: 'Settings',
            icon: 'assets/icons/Settings.svg',
            onPressed: () {},
          ),
          ProfileMenu(
            text: 'About',
            icon: 'assets/icons/Question mark.svg',
            onPressed: () => showAboutDialog(
              context: context,
              applicationVersion: '1.0',
              applicationLegalese: "This is a demo product",
            ),
          ),
          ProfileMenu(
            text: 'Log Out',
            icon: 'assets/icons/Log out.svg',
            onPressed: () {
              auth.signOut(context).then((_) {
                Navigator.pushReplacementNamed(context, SignInScreen.route);
              });
            },
          ),
        ],
      ),
    );
  }
}
