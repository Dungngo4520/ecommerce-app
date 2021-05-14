import 'package:algolia/algolia.dart';
import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/details_screen.dart';
import 'package:ecommerce/screens/search/components/search_input_provider.dart';
import 'package:ecommerce/services/algolia_search.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Cart> cartList = Provider.of<List<Cart>>(context);
    final seachInputState = Provider.of<SearchInputProvider>(context);
    if (seachInputState.searchInput == "") {
      return Expanded(
        child: Center(
          child: Text("Search for product"),
        ),
      );
    } else {
      return StreamBuilder<List<Product>>(
        stream: Stream.fromFuture(
            AlgoliaSearch().searchProduct(seachInputState.searchInput)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      snapshot.data!.length,
                      (index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Provider(
                              create: (context) => cartList,
                              builder: (context, child) => DetailsScreen(),
                            ),
                            settings: RouteSettings(
                              arguments: ProductDetailsAgrument(
                                product: snapshot.data![index],
                                heroTag: snapshot.data![index].id + 'search',
                              ),
                            ),
                          ),
                        ),
                        child: Hero(
                          tag: snapshot.data![index].id + 'search',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  height: getProportionateScreenWidth(100),
                                  width: getProportionateScreenWidth(100),
                                  child: Image.network(
                                      snapshot.data![index].images[0]),
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
                                          snapshot.data![index].title,
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
                                                  snapshot.data![index].rating
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
                                                          .data![index].price)
                                                      .toString() +
                                                  '₫',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: cPrimaryColor),
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
            } else {
              Center(child: Text("Found nothing. ¯\_(ツ)_/¯"));
            }
          } else {
            Center(child: Text("Found nothing. ¯\_(ツ)_/¯"));
          }
          return LoadingScreen();
        },
      );
    }
  }
}
