import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/models/UserData.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
    required this.product,
    required this.cartList,
    required this.index,
  }) : super(key: key);

  final Product product;
  final List<Cart> cartList;
  final int index;

  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<DatabaseMethods>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: getProportionateScreenWidth(88),
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(
                  product.images[0],
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
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(10)),
            width: SizeConfig.screenWidth - getProportionateScreenWidth(150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: getProportionateScreenWidth(14)),
                ),
                FutureBuilder<UserData>(
                  future: firestore.getUserById(product.ownerId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'Provided by Dung Ngo',
                        style: TextStyle(fontSize: getProportionateScreenWidth(12)),
                      );
                    }
                    return LoadingScreen();
                  },
                ),
                Text(
                  '${NumberFormat(',###').format(product.price)} ₫ x${cartList[index].quantity}',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}