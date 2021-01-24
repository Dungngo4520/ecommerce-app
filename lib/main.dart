import 'package:ecommerce/routes.dart';
import 'package:ecommerce/screens/splash/splash_screen.dart';
import 'package:ecommerce/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: SplashScreen.route,
      routes: routes,
    );
  }
}
