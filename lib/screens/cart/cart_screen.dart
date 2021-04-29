import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/screens/cart/components/body.dart';
import 'package:ecommerce/screens/cart/components/checkout_card.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static String route = 'cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckOutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          Text(
            'Your Cart',
            style: TextStyle(color: Colors.black87),
          ),
          Text(
            '${demoCarts.length} items',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
