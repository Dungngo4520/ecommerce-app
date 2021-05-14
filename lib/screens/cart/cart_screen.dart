import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/screens/cart/components/body.dart';
import 'package:ecommerce/screens/cart/components/checkout_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String route = '/cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckOutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    List<Cart> cartList = Provider.of<List<Cart>>(context);
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          Text(
            'Your Cart',
            style: TextStyle(color: Colors.black87),
          ),
          Text(
            '${cartList.length} items',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
