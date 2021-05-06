import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/components/body.dart';
import 'package:ecommerce/screens/details/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  static String route = '/details';
  @override
  Widget build(BuildContext context) {
    final ProductDetailsAgrument agrument =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsAgrument;

    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(rating: agrument.product.rating),
      body: Body(
        product: agrument.product,
        heroTag: agrument.heroTag,
      ),
    );
  }
}

class ProductDetailsAgrument {
  final Product product;
  final heroTag;

  ProductDetailsAgrument({required this.product, required this.heroTag});
}
