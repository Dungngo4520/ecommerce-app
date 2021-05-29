import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Order.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/order/components/order_item.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<DatabaseMethods>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: cPrimaryColor,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cart Infomation',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            StreamBuilder<List<Cart>>(
              stream: firestore.getOrderItems(order.id),
              builder: (context, listCart) {
                if (listCart.hasData) {
                  return Column(
                    children: [
                      ...List.generate(
                        listCart.data!.length,
                        (index) {
                          return FutureBuilder<Product>(
                            future: firestore.getProductByID(listCart.data![index].productID),
                            builder: (context, product) {
                              if (product.hasData) {
                                return OrderItem(
                                  cartList: listCart.data!,
                                  product: product.data!,
                                  index: index,
                                );
                              }
                              return LoadingScreen();
                            },
                          );
                        },
                      ),
                    ],
                  );
                }
                return LoadingScreen();
              },
            ),
            Divider(),
          ],
        ),
      ],
    );
  }
}
