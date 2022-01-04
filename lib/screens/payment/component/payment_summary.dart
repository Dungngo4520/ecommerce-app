import 'package:ecommerce/constants.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int amount = Provider.of<int>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              bottom: getProportionateScreenHeight(10), left: getProportionateScreenWidth(20)),
          child: Text('SUMMARY'),
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
                horizontal: getProportionateScreenWidth(20),
              ),
              decoration: BoxDecoration(color: cSecondaryColor.withAlpha(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Total ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: 'including VAT',
                          style: TextStyle(color: cTextColor.withAlpha(90)),
                        ),
                      ],
                    ),
                  ),
                  Text('${NumberFormat(',###').format(amount)} ₫'),
                ],
              ),
            ),
            Divider(thickness: 1, height: 0),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
                horizontal: getProportionateScreenWidth(20),
              ),
              decoration: BoxDecoration(color: cSecondaryColor.withAlpha(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('0 ₫'),
                ],
              ),
            ),
            Divider(thickness: 1, height: 0),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
                horizontal: getProportionateScreenWidth(20),
              ),
              decoration: BoxDecoration(color: cSecondaryColor.withAlpha(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'After Discount',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${NumberFormat(',###').format(amount)} ₫'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
