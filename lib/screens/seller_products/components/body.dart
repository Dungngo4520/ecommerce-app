import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/seller_products/components/product_item.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          demoProducts.length,
          (index) => ProductItem(product: demoProducts[index]),
        )
      ],
    );
  }
}
