import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: onPressed,
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: cSecondaryColor.withOpacity(0.1),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
              color: cPrimaryColor,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: cTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
