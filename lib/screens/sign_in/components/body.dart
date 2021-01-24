import 'package:ecommerce/components/no_account_text.dart';
import 'package:ecommerce/components/social_dot.dart';
import 'package:ecommerce/screens/sign_in/components/sign_form.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Sign in with your email and password\n or continue with social media',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.06,
                ),
                SignForm(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialDot(
                      icon: 'assets/icons/google-icon.svg',
                      onPressed: () {},
                    ),
                    SocialDot(
                      icon: 'assets/icons/facebook.svg',
                      onPressed: () {},
                    ),
                    SocialDot(
                      icon: 'assets/icons/twitter.svg',
                      onPressed: () {},
                    ),
                  ],
                ),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
