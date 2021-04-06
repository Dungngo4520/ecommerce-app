import 'package:ecommerce/screens/complete_profile/components/body.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String route = '/complete_profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Body(
          userEmailAndPassword:
              ModalRoute.of(context)!.settings.arguments as List<String>),
    );
  }
}
