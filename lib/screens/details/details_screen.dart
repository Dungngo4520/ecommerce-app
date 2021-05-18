import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/components/body.dart';
import 'package:ecommerce/screens/details/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  static String route = '/details';
  @override
  Widget build(BuildContext context) {
    final ProductDetailsAgrument agrument =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsAgrument;
    List<Cart> cartList = Provider.of<List<Cart>>(context);
    return MultiProvider(
      providers: [
        Provider<Cart>.value(
          value: cartList.firstWhere((e) => e.productID == agrument.product.id,
              orElse: () => Cart(id: "", productID: "", quantity: 0)),
        ),
        ChangeNotifierProvider<ValueNotifier<int>>(
          create: (context) => ValueNotifier(cartList
              .firstWhere((e) => e.productID == agrument.product.id,
                  orElse: () => Cart(id: "", productID: "", quantity: 0))
              .quantity),
        ),
        ChangeNotifierProvider<ValueNotifier<bool>>(
          create: (context) => ValueNotifier(false),
        ),
      ],
      builder: (context, child) => Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: CustomAppBar(rating: agrument.product.rating),
        body: Body(
          product: agrument.product,
          heroTag: agrument.heroTag,
        ),
      ),
    );
  }
}

class ProductDetailsAgrument {
  final Product product;
  final heroTag;

  ProductDetailsAgrument({required this.product, required this.heroTag});
}
