import 'package:ecommerce/components/custom_bottom_navbar.dart';
import 'package:ecommerce/enum.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  static String route = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
