import 'package:ecommerce/components/custom_bottom_navbar.dart';
import 'package:ecommerce/enum.dart';
import 'package:ecommerce/screens/favorite/components/body.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static String route = '/favorite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favorite),
    );
  }
}
