import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/screens/cart/cart_screen.dart';
import 'package:ecommerce/screens/home/components/icon_button_with_counter.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Cart> cartList = Provider.of<List<Cart>>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SearchField(),
          Container(
            width: SizeConfig.screenWidth * 0.6,
            child: Text(
              'EMO Shopping',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                color: cPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButtonWithCounter(
            image: 'assets/icons/Cart Icon.svg',
            count: cartList.length,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Provider(
                    create: (context) => cartList,
                    builder: (context, child) => CartScreen(),
                  ),
                )),
          ),
          IconButtonWithCounter(
            image: 'assets/icons/Bell.svg',
            count: 7,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
