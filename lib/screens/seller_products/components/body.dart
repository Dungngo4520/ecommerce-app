import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/seller_products/components/product_item.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (demoProducts.length == 0) {
      return Center(
        child: Text(
          "Nothing here. Press the add \"+\" button below to start adding more item.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: cSecondaryColor),
        ),
      );
    } else
      return demoProducts.length != 0
          ? ProductItems(product: demoProducts)
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Text(
                  "Nothing here. Press the add \"+\" button below to start adding more item.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: cSecondaryColor),
                ),
              ),
            );
  }
}
