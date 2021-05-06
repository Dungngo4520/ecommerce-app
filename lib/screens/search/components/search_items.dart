import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/details_screen.dart';
import 'package:ecommerce/screens/search/components/search_input_provider.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final seachInputState = Provider.of<SearchInputProvider>(context);
    return seachInputState.searchInput == ""
        ? Expanded(
            child: Center(
              child: Text("Search product"),
            ),
          )
        : SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  demoProducts.length,
                  (index) => GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      DetailsScreen.route,
                      arguments: ProductDetailsAgrument(
                        product: demoProducts[index],
                        heroTag: demoProducts[index].id + 'search',
                      ),
                    ),
                    child: Hero(
                      tag: demoProducts[index].id + 'search',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              height: getProportionateScreenWidth(100),
                              width: getProportionateScreenWidth(100),
                              child:
                                  Image.network(demoProducts[index].images[0]),
                            ),
                            Expanded(
                              child: Container(
                                height: getProportionateScreenWidth(80),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      demoProducts[index].title,
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
                                              demoProducts[index]
                                                  .rating
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(width: 5),
                                            SvgPicture.asset(
                                                'assets/icons/Star Icon.svg')
                                          ],
                                        ),
                                        Text(
                                          NumberFormat(',###')
                                                  .format(
                                                      demoProducts[index].price)
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
  }
}
