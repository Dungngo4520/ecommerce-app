import 'package:ecommerce/screens/otp/components/body.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  static String route = '/otp';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
