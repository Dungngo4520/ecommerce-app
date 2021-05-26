import 'package:ecommerce/screens/cart/cart_screen.dart';
import 'package:ecommerce/screens/chat/chat_screen.dart';
import 'package:ecommerce/screens/complete_profile/comple_profile_screen.dart';
import 'package:ecommerce/screens/details/details_screen.dart';
import 'package:ecommerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:ecommerce/screens/my_account/my_account_screen.dart';
import 'package:ecommerce/screens/otp/opt_screen.dart';
import 'package:ecommerce/screens/profile/profile_screen.dart';
import 'package:ecommerce/screens/search/search_screen.dart';
import 'package:ecommerce/screens/seller_products/seller_products_screen.dart';
import 'package:ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:ecommerce/screens/sign_up/sign_up_screen.dart';
import 'package:ecommerce/screens/splash/splash_screen.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.route: (context) => SplashScreen(),
  SignInScreen.route: (context) => SignInScreen(),
  ForgotPasswordScreen.route: (context) => ForgotPasswordScreen(),
  SignUpScreen.route: (context) => SignUpScreen(),
  CompleteProfileScreen.route: (context) => CompleteProfileScreen(),
  OTPScreen.route: (context) => OTPScreen(),
  HomeScreen.route: (context) => HomeScreen(),
  DetailsScreen.route: (context) => DetailsScreen(),
  CartScreen.route: (context) => CartScreen(),
  ProfileScreen.route: (context) => ProfileScreen(),
  ChatScreen.route: (context) => ChatScreen(),
  SellerProductsScreen.route: (context) => SellerProductsScreen(),
  SearchScreen.route: (context) => SearchScreen(),
  MyAccountScreen.route: (context) => MyAccountScreen(),
};
