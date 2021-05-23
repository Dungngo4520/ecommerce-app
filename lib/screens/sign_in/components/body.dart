import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/screens/sign_in/components/no_account_text.dart';
import 'package:ecommerce/screens/sign_in/components/social_dot.dart';
import 'package:ecommerce/screens/sign_in/components/sign_form.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthMethods>(context);
    return loading
        ? LoadingScreen()
        : SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
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
                      Text("Or sign in with Google"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialDot(
                            icon: 'assets/icons/google-icon.svg',
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              if (!await auth.signInWithGoogle(context))
                                setState(() {
                                  loading = false;
                                });
                            },
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
