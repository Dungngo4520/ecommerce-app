import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:ecommerce/screens/splash/splash_screen.dart';
import 'package:ecommerce/services/shared_preference_helper.dart';
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
      if (userSnapshot.hasData) {
        return HomeScreen();
      } else {
        return StreamBuilder<bool?>(
            stream: Stream.fromFuture(SharedPreferenceHelper().getIsOpened()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!)
                  return SignInScreen();
              }
              return SplashScreen();
            });
      }
    }
    return Scaffold(
      body: LoadingScreen(),
    );
  }
}
