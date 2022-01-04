import 'package:ecommerce/screens/home/components/browse_product.dart';
import 'package:ecommerce/screens/home/components/home_banner.dart';
import 'package:ecommerce/screens/home/components/home_header.dart';
import 'package:ecommerce/screens/home/components/popular_products.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(30)),
            HomeBanner(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
            BrowseProduct()
          ],
        ),
      ),
    );
  }
}
