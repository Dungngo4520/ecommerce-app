import 'package:ecommerce/screens/home/components/category_card.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categories = [
      {'icon': 'assets/icons/Flash Icon.svg', 'text': 'Flash Deal'},
      {'icon': 'assets/icons/Bill Icon.svg', 'text': 'My Orders'},
      {'icon': 'assets/icons/Game Icon.svg', 'text': 'Game'},
      {'icon': 'assets/icons/Gift Icon.svg', 'text': 'Daily Gift'},
    ];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            categories.length,
            (index) => CategoryCard(
              icon: categories[index]['icon']!,
              text: categories[index]['text']!,
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
