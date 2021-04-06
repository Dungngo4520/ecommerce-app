import 'package:ecommerce/constants.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconButtonWithCounter extends StatelessWidget {
  const IconButtonWithCounter({
    Key? key,
    required this.image,
    this.count = 0,
    required this.onTap,
  }) : super(key: key);

  final String image;
  final int count;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            height: getProportionateScreenWidth(46),
            width: getProportionateScreenWidth(46),
            decoration: BoxDecoration(
              color: cSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(image),
          ),
          if (count > 0)
            Positioned(
              right: 0,
              top: -3,
              child: Container(
                height: getProportionateScreenWidth(20),
                width: getProportionateScreenWidth(20),
                decoration: BoxDecoration(
                  color: cPrimaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$count",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenWidth(10),
                      height: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
