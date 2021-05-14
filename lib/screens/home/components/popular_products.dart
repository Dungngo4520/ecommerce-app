import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/details_screen.dart';
import 'package:ecommerce/screens/home/components/product_card.dart';
import 'package:ecommerce/screens/home/components/section_title.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<DatabaseMethods>(context);
    List<Cart> cartList = Provider.of<List<Cart>>(context);
    return FutureBuilder<List<Product>>(
      initialData: [],
      future: firestore.getProducts(5),
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
                      product: snapshot.data![index],
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
                              heroTag: snapshot.data![index].id + 'popular',
                            ),
                          ),
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
