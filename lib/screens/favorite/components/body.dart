import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/favorite/components/favorite_item.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: demoProducts.length,
        itemBuilder: (context, index) => FavoriteItem(
          product: demoProducts[index],
        ),
      ),
    );
  }
}
