import 'package:ecommerce/constants.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
          color: cSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Search products',
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(10)),
        ),
      ),
    );
  }
}
