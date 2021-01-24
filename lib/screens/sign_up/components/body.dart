import 'package:ecommerce/components/social_dot.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/sign_up/components/sign_up_form.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Register Account',
                style: headingStyle,
                textAlign: TextAlign.center,
              ),
              Text(
                'Complete your details\n or continue with social media',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              SignUpForm(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
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
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                'By continuing your confirm that you agree\n with our Terms and Conditions',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
