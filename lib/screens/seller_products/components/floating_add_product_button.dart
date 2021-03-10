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
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.add,
          color: cPrimaryColor,
        ),
        splashColor: cPrimaryColor.withOpacity(0.2),
        highlightColor: cPrimaryColor.withOpacity(0.2),
        splashRadius: 24,
      ),
    );
  }
}
