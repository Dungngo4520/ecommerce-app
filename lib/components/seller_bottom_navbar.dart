import 'package:ecommerce/constants.dart';
import 'package:ecommerce/enum.dart';
import 'package:ecommerce/screens/seller_products/seller_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellerBottomNavBar extends StatelessWidget {
  const SellerBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/Product.svg',
                color: MenuState.seller_product == selectedMenu
                    ? cPrimaryColor
                    : cSecondaryColor,
              ),
              onPressed: () {
                if (selectedMenu != MenuState.seller_product)
                  Navigator.pushReplacementNamed(
                      context, SellerProductsScreen.route);
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/Order.svg',
                color: MenuState.seller_order == selectedMenu
                    ? cPrimaryColor
                    : cSecondaryColor,
              ),
              onPressed: () {
                if (selectedMenu != MenuState.seller_product)
                  Navigator.pushReplacementNamed(
                      context, SellerProductsScreen.route);
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/Finance.svg',
                color: MenuState.seller_finance == selectedMenu
                    ? cPrimaryColor
                    : cSecondaryColor,
              ),
              onPressed: () {
                if (selectedMenu != MenuState.seller_product)
                  Navigator.pushReplacementNamed(
                      context, SellerProductsScreen.route);
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/Settings.svg',
                color: MenuState.seller_setting == selectedMenu
                    ? cPrimaryColor
                    : cSecondaryColor,
              ),
              onPressed: () {
                if (selectedMenu != MenuState.seller_product)
                  Navigator.pushReplacementNamed(
                      context, SellerProductsScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
