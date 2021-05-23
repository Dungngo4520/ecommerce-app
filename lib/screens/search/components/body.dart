import 'package:ecommerce/screens/search/components/search_field.dart';
import 'package:ecommerce/screens/search/components/search_items.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchField(),
            SearchItems(),
          ],
        ),
      ),
    );
  }
}
