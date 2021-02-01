import 'package:ecommerce/screens/login_success/components/body.dart';
import 'package:flutter/material.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String route = '/login_success';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text('Login Success'),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}