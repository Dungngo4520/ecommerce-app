import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/details_screen.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BrowseProduct extends StatelessWidget {
  const BrowseProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot>>(
        initialData: [],
        future: DatabaseMethods().getProducts(10).then((value) => value.docs),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Browse",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
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
                    (index) => GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        DetailsScreen.route,
                        arguments: ProductDetailsAgrument(
                          product: Product.fromMap({
                            'id': snapshot.data![index].id,
                            ...snapshot.data![index].data()
                          }),
                          heroTag: snapshot.data![index].id + 'browse',
                        ),
                      ),
                      child: Hero(
                        tag: snapshot.data![index].id + 'browse',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                height: getProportionateScreenWidth(100),
                                width: getProportionateScreenWidth(100),
                                child: Image.network(
                                    snapshot.data![index].data()['images'][0]),
                              ),
                              Expanded(
                                child: Container(
                                  height: getProportionateScreenWidth(80),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot.data![index].data()['title'] ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data![index]
                                                    .data()['rating']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(width: 5),
                                              SvgPicture.asset(
                                                  'assets/icons/Star Icon.svg')
                                            ],
                                          ),
                                          Text(
                                            NumberFormat(',###')
                                                    .format(snapshot
                                                        .data![index]
                                                        .data()['price'])
                                                    .toString() +
                                                '₫',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style:
                                                TextStyle(color: cPrimaryColor),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          );
        });
  }
}
