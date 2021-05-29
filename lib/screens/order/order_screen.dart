import 'package:ecommerce/screens/order/components/body.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: Text('Order'),
      ),
      body: Body(orderId: orderId),
    );
  }
}
