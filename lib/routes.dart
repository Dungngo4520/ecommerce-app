import 'package:ecommerce/screens/complete_profile/comple_profile_screen.dart';
import 'package:ecommerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:ecommerce/screens/login_success/login_success_screen.dart';
import 'package:ecommerce/screens/otp/opt_screen.dart';
import 'package:ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:ecommerce/screens/sign_up/sign_up_screen.dart';
import 'package:ecommerce/screens/splash/splash_screen.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.route: (context) => SplashScreen(),
  SignInScreen.route: (context) => SignInScreen(),
  ForgotPasswordScreen.route: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.route: (context) => LoginSuccessScreen(),
  SignUpScreen.route: (context) => SignUpScreen(),
  CompleteProfileScreen.route: (context) => CompleteProfileScreen(),
  OTPScreen.route: (context) => OTPScreen(),
  HomeScreen.route: (context) => HomeScreen(),
};
