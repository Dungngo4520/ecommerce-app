import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Order.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class OrderPayment extends StatelessWidget {
  const OrderPayment({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
          child: Icon(
            Icons.payment_outlined,
            color: cPrimaryColor,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Paid ${order.paymentMethod == 'Momo' ? 'with Momo E-Wallet' : 'Directly'}'),
          ],
        )
      ],
    );
  }
}
