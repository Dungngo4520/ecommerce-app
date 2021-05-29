import 'package:ecommerce/screens/order_list/components/body.dart';
import 'package:flutter/material.dart';

class OrderListScreen extends StatelessWidget {
  static final String route = 'orderList';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
      ),
      body: Body(),
    );
  }
}
