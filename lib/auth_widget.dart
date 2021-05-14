import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:ecommerce/screens/splash/splash_screen.dart';
import 'package:ecommerce/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatelessWidget {
  final AsyncSnapshot<User?> userSnapshot;

  const AuthWidget({Key? key, required this.userSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomeScreen() : SplashScreen();
    }
    return Scaffold(
      body: Center(
        child: LoadingScreen(),
      ),
    );
  }
}
