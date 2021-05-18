import 'package:ecommerce/components/custom_bottom_navbar.dart';
import 'package:ecommerce/enum.dart';
import 'package:ecommerce/screens/search/components/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  static String route = '/search';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<String>>(
      create: (context) => ValueNotifier<String>(""),
      builder: (context, child) => Scaffold(
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.search),
      ),
    );
  }
}
