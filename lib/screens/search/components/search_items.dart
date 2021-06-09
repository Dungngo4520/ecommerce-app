import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/details_screen.dart';
import 'package:ecommerce/services/algolia_search.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final seachInputState = Provider.of<ValueNotifier<String>>(context);
    if (seachInputState.value == "") {
      return Center(
        child: Text("Search for product"),
      );
    } else {
      return StreamBuilder<List<Product>>(
        stream: Stream.fromFuture(AlgoliaSearch().searchProduct(seachInputState.value)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return SingleChildScrollView(
                clipBehavior: Clip.none,
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      snapshot.data!.length,
                      (index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(),
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
                                    snapshot.data![index].images[0],
                                    errorBuilder: (context, error, stackTrace) => Icon(Icons.image),
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: cPrimaryColor,
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: getProportionateScreenWidth(80),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            snapshot.data![index].title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data![index].rating.toString(),
                                                  style: TextStyle(fontWeight: FontWeight.w600),
                                                ),
                                                const SizedBox(width: 5),
                                                SvgPicture.asset('assets/icons/Star Icon.svg')
                                              ],
                                            ),
                                            Text(
                                              NumberFormat(',###')
                                                      .format(snapshot.data![index].price)
                                                      .toString() +
                                                  '₫',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(color: cPrimaryColor),
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
              return Center(child: Text("Found nothing. ¯\_(ツ)_/¯"));
            }
          } else
            return LoadingScreen();
        },
      );
    }
  }
}
