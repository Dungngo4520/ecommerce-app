import 'package:ecommerce/constants.dart';
import 'package:ecommerce/enum.dart';
import 'package:ecommerce/screens/chat/chat_screen.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:ecommerce/screens/profile/profile_screen.dart';
import 'package:ecommerce/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: cSecondaryColor.withOpacity(0.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/Discover.svg',
                    // height: 30,
                    color: MenuState.home == selectedMenu
                        ? cPrimaryColor
                        : cSecondaryColor,
                  ),
                  onPressed: () {
                    if (selectedMenu != MenuState.home)
                      Navigator.pushReplacementNamed(context, HomeScreen.route);
                  },
                ),
                Text("Home", style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/Search Icon.svg',
                    color: MenuState.search == selectedMenu
                        ? cPrimaryColor
                        : cSecondaryColor,
                  ),
                  onPressed: () {
                    if (selectedMenu != MenuState.search)
                      Navigator.pushReplacementNamed(
                          context, SearchScreen.route);
                  },
                ),
                Text("Search", style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/Chat bubble Icon.svg',
                    color: MenuState.message == selectedMenu
                        ? cPrimaryColor
                        : cSecondaryColor,
                  ),
                  onPressed: () {
                    if (selectedMenu != MenuState.message)
                      Navigator.pushReplacementNamed(context, ChatScreen.route);
                  },
                ),
                Text("Chat", style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/User Icon.svg',
                    color: MenuState.profile == selectedMenu
                        ? cPrimaryColor
                        : cSecondaryColor,
                  ),
                  onPressed: () {
                    if (selectedMenu != MenuState.profile)
                      Navigator.pushReplacementNamed(
                          context, ProfileScreen.route);
                  },
                ),
                Text("Profile", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
