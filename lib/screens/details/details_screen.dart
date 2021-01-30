import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/components/body.dart';
import 'package:ecommerce/screens/details/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  static String route = '/details';
  @override
  Widget build(BuildContext context) {
    final ProductDetailsAgrument agrument =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(agrument.product.rating),
      body: Body(product: agrument.product),
    );
  }
}

class ProductDetailsAgrument {
  final Product product;

  ProductDetailsAgrument({@required this.product});
}
