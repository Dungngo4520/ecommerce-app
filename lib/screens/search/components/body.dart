import 'package:ecommerce/screens/search/components/search_field.dart';
import 'package:ecommerce/screens/search/components/search_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchField(),
          Flexible(child: SearchItems()),
        ],
      ),
    );
  }
}
