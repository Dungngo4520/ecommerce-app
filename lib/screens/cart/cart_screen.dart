import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/screens/cart/components/body.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class CheckOutCard extends StatelessWidget {
  const CheckOutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15),
        vertical: getProportionateScreenWidth(30),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: cSecondaryColor.withOpacity(0.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: cSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset('assets/icons/receipt.svg'),
                ),
                Spacer(),
                Text('Add voucher code'),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: cTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenWidth(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Total:\n',
                    children: [
                      TextSpan(
                        text:
                            '\$${demoCarts.fold(0, (previousValue, element) => (previousValue! as double) + element.product.price)}',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: 'Check Out',
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
