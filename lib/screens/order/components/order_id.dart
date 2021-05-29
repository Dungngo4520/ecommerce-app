import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Order.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderID extends StatelessWidget {
  const OrderID({
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
            Icons.receipt_outlined,
            color: cPrimaryColor,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text('Order Date: '),
                Text(DateFormat('kk:mm - dd-MM-yyyy').format(order.created.toDate())),
              ],
            ),
            Text(
              order.status,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }
}
