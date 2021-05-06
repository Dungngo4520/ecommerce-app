import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/details_screen.dart';
import 'package:ecommerce/screens/home/components/product_card.dart';
import 'package:ecommerce/screens/home/components/section_title.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot>>(
      initialData: [],
      future: DatabaseMethods().getProducts(5).then((value) => value.docs),
      builder: (context, snapshot) => Column(
        children: [
          SectionTitle(text: 'Popular Products', onTap: () {}),
          SizedBox(height: getProportionateScreenWidth(20)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (snapshot.data!.isEmpty)
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: Text('Nothing to view'),
                    ),
                  )
                else
                  ...List.generate(
                    snapshot.data!.length,
                    (index) => ProductCard(
                      product: Product.fromMap({
                        'id': snapshot.data![index].id,
                        ...snapshot.data![index].data()
                      }),
                      onTap: () => Navigator.pushNamed(
                        context,
                        DetailsScreen.route,
                        arguments: ProductDetailsAgrument(
                          product: Product.fromMap({
                            'id': snapshot.data![index].id,
                            ...snapshot.data![index].data()
                          }),
                          heroTag: snapshot.data![index].id + 'popular',
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: getProportionateScreenWidth(20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
