import 'package:ecommerce/screens/cart/cart_screen.dart';
import 'package:ecommerce/screens/home/components/icon_button_with_counter.dart';
import 'package:ecommerce/screens/home/components/search_field.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconButtonWithCounter(
            image: 'assets/icons/Cart Icon.svg',
            onTap: () => Navigator.pushNamed(context, CartScreen.route),
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
