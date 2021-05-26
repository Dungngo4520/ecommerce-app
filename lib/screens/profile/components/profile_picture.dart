import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/UserData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfilePicture extends StatelessWidget {
  final bool changeable;
  const ProfilePicture({
    Key? key,
    required this.changeable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black.withAlpha(20),
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                userData.photoURL,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 110,
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: cPrimaryColor,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          if (changeable)
            Positioned(
              bottom: 0,
              right: -12,
              child: SizedBox(
                height: 46,
                width: 46,
                // ignore: deprecated_member_use
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  color: Color(0xfff5f6f9),
                  onPressed: () {},
                  child: SvgPicture.asset('assets/icons/Camera Icon.svg'),
                ),
              ),
            )
        ],
      ),
    );
  }
}
