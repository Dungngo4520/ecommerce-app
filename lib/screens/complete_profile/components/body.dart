import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/complete_profile/components/complete_profile_form.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final List<String> userEmailAndPassword;

  const Body({Key? key, required this.userEmailAndPassword}) : super(key: key);

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
                'Complete your details',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              CompleteProfileForm(userEmailAndPassword: userEmailAndPassword),
              SizedBox(height: getProportionateScreenHeight(40)),
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
