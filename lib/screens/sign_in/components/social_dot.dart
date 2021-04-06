import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialDot extends StatelessWidget {
  const SocialDot({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Container(
        margin: EdgeInsets.all(getProportionateScreenWidth(10)),
        alignment: Alignment.center,
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        height: getProportionateScreenHeight(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          color: Colors.black12,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
