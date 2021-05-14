import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/components/color_dots.dart';
import 'package:ecommerce/screens/details/components/product_description.dart';
import 'package:ecommerce/screens/details/components/product_images.dart';
import 'package:ecommerce/screens/details/components/top_rounded_container.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final Product product;
  final String heroTag;

  const Body({Key? key, required this.product, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Cart> cartList = Provider.of<List<Cart>>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImages(
            product: product,
            heroTag: heroTag,
          ),
          TopRoundedCorner(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  onTapSeeMore: () {},
                ),
                TopRoundedCorner(
                  color: cSecondaryColor.withOpacity(0.1),
                  child: Column(
                    children: [
                      ColorDots(product: product),
                      TopRoundedCorner(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.15,
                            right: SizeConfig.screenWidth * 0.15,
                            top: getProportionateScreenWidth(15),
                            bottom: getProportionateScreenWidth(40),
                          ),
                          child: DefaultButton(
                            text: 'Add to Cart',
                            onPressed: () {
                              demoCarts.add(
                                  new Cart(productID: product.id, quantity: 1));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
