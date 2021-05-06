import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/search/components/search_input_provider.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController searchInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final seachInputState = Provider.of<SearchInputProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: cSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: searchInputController,
        onEditingComplete: () {
          seachInputState.searchInput = searchInputController.text;
        },
        onTap: () {
          searchInputController.selection = TextSelection(
              baseOffset: 0, extentOffset: searchInputController.text.length);
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Search products',
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(10)),
        ),
      ),
    );
  }
}
