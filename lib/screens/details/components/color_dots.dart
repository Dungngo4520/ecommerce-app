import 'package:ecommerce/components/rounded_icon_button.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ColorDotsState createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            widget.product.colors.length,
            (index) => buildColorDot(index),
          ),
          Spacer(),
          RoundedIconButton(
            iconData: Icons.remove,
            onTap: () {},
          ),
          SizedBox(width: getProportionateScreenWidth(15)),
          RoundedIconButton(
            iconData: Icons.add,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  GestureDetector buildColorDot(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 2),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color:
                  index == selectedColor ? cPrimaryColor : Colors.transparent),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.product.colors[index],
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
