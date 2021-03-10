import 'package:ecommerce/components/seller_bottom_navbar.dart';
import 'package:ecommerce/enum.dart';
import 'package:ecommerce/screens/seller_products/components/body.dart';
import 'package:ecommerce/screens/seller_products/components/floating_add_product_button.dart';
import 'package:flutter/material.dart';

class SellerProductsScreen extends StatelessWidget {
  static String route = '/seller_product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        centerTitle: true,
      ),
      body: Body(),
      floatingActionButton: FloatingAddProductButton(onPressed: () {}),
      bottomNavigationBar:
          SellerBottomNavBar(selectedMenu: MenuState.seller_product),
    );
  }
}
