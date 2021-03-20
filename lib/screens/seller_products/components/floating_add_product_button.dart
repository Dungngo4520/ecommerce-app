import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class FloatingAddProductButton extends StatelessWidget {
  const FloatingAddProductButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cPrimaryColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Icon(
            Icons.add,
            color: cPrimaryColor,
            size: 25,
          ),
        ),
      ),
    );
  }
}
