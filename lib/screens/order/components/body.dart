import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/models/Order.dart';
import 'package:ecommerce/screens/order/components/order_id.dart';
import 'package:ecommerce/screens/order/components/order_info.dart';
import 'package:ecommerce/screens/order/components/order_payment.dart';
import 'package:ecommerce/screens/order/components/receiver_info.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<DatabaseMethods>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: FutureBuilder<Order>(
            future: firestore.getOrderbyId(orderId),
            builder: (context, order) {
              if (order.hasData) {
                return Column(
                  children: [
                    OrderID(order: order.data!),
                    Divider(),
                    ReceiverInfo(order: order.data!),
                    Divider(),
                    OrderInfo(order: order.data!),
                    Divider(),
                    OrderPayment(order: order.data!),
                    Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Amount'),
                          Text('${NumberFormat(',###').format(order.data!.amount)} ₫'),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Discount'),
                          Text('-${NumberFormat(',###').format(order.data!.discount)} ₫'),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${NumberFormat(',###').format(order.data!.amount - order.data!.discount)} ₫',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: getProportionateScreenWidth(16)),
                              ),
                              Text(
                                'Included VAT',
                                style: TextStyle(fontSize: getProportionateScreenWidth(13)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return LoadingScreen();
            },
          ),
        ),
      ),
    );
  }
}
