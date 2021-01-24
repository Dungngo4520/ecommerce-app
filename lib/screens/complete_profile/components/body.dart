import 'package:ecommerce/components/social_dot.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/complete_profile/components/complete_profile_form.dart';
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
                'Complete Profile',
                style: headingStyle,
              ),
              Text(
                'Complete your details or\ncontinue with your social media',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              CompleteProfileForm(),
              SizedBox(height: getProportionateScreenHeight(20)),
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
              SizedBox(height: getProportionateScreenHeight(10)),
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
