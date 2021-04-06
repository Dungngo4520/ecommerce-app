import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/components/color_dots.dart';
import 'package:ecommerce/screens/details/components/product_description.dart';
import 'package:ecommerce/screens/details/components/product_images.dart';
import 'package:ecommerce/screens/details/components/top_rounded_container.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImages(product: product),
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
                            onPressed: () {},
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
