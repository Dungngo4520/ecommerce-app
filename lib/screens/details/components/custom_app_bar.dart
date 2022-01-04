import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ecommerce/components/rounded_icon_button.dart';
import 'package:ecommerce/size_config.dart';

class CustomAppBar extends PreferredSize {
  final double rating;

  CustomAppBar({required this.rating})
      : super(child: AppBar(), preferredSize: Size.fromHeight(AppBar().preferredSize.height));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Transform.translate(
        offset: Offset(0, getProportionateScreenHeight(-10)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          margin: EdgeInsets.only(top: getProportionateScreenHeight(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedIconButton(
                iconData: Icons.arrow_back,
                onTap: () => Navigator.pop(context),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15),
                  vertical: getProportionateScreenWidth(5),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Text(
                      rating.toString(),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: getProportionateScreenWidth(5)),
                    SvgPicture.asset('assets/icons/Star Icon.svg')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
