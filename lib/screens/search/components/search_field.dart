import 'package:ecommerce/constants.dart';
// import 'package:ecommerce/models/Product.dart';
// import 'package:ecommerce/services/algolia_admin.dart';
// import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  // AlgoliaSearch algoliaSearch = AlgoliaSearch();
  TextEditingController searchInputController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    // final firestore = Provider.of<DatabaseMethods>(context);
    final seachInputState = Provider.of<ValueNotifier<String>>(context);
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: cSecondaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
      child: Focus(
        child: TextField(
          focusNode: focusNode,
          autofocus: true,
          controller: searchInputController,
          onEditingComplete: () async {
            seachInputState.value = searchInputController.text;
            focusNode.unfocus();
            // demoProducts.forEach((element) {
            //   algoliaSearch.sendData(element.toMap());
            //   firestore.setProductToDB(element.id, element.toMap());
            // });
          },
          onTap: () {
            searchInputController.selection =
                TextSelection(baseOffset: 0, extentOffset: searchInputController.text.length);
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
      ),
    );
  }
}
