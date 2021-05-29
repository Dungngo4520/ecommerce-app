import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Order.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class ReceiverInfo extends StatelessWidget {
  const ReceiverInfo({
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
              Icons.location_on_outlined,
              color: cPrimaryColor,
            )),
        Container(
          width: SizeConfig.screenWidth - getProportionateScreenWidth(70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Address',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(order.receiverName),
              Text(order.receiverPhone),
              Text(order.address),
            ],
          ),
        )
      ],
    );
  }
}