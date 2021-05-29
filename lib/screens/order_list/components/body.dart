import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Order.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/order/order_screen.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<DatabaseMethods>(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        child: StreamBuilder<List<Order>>(
          stream: firestore.getOrders(),
          builder: (context, orderList) {
            if (orderList.hasData) {
              return ListView.separated(
                itemCount: orderList.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(orderId: orderList.data![index].id),
                          ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderList.data![index].status,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: getProportionateScreenWidth(13),
                          ),
                        ),
                        Divider(),
                        StreamBuilder<List<Cart>>(
                          stream: firestore.getOrderItems(orderList.data![index].id),
                          builder: (context, cartList) {
                            if (cartList.hasData) {
                              return StreamBuilder<Product>(
                                stream: Stream.fromFuture(
                                    firestore.getProductByID(cartList.data![0].productID)),
                                builder: (context, product) {
                                  if (product.hasData) {
                                    return Row(
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
                                                product.data!.images[0],
                                                errorBuilder: (context, error, stackTrace) =>
                                                    Icon(Icons.image),
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child: CircularProgressIndicator(
                                                      color: cPrimaryColor,
                                                      value: loadingProgress.expectedTotalBytes !=
                                                              null
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
                                          padding: EdgeInsets.only(
                                              left: getProportionateScreenWidth(10)),
                                          width: SizeConfig.screenWidth -
                                              getProportionateScreenWidth(120),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.data!.title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              if (cartList.data!.length > 1)
                                                Text(
                                                    'And ${cartList.data!.length - 1} more item${cartList.data!.length - 1 > 1 ? 's' : ''}'),
                                              Text(
                                                '${cartList.data!.length} item${cartList.data!.length > 1 ? 's' : ''} | ${NumberFormat(',###').format(orderList.data![index].amount)} ₫',
                                                style: TextStyle(color: cTextColor.withAlpha(150)),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  return LoadingScreen();
                                },
                              );
                            }
                            return LoadingScreen();
                          },
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  thickness: getProportionateScreenHeight(5),
                ),
              );
            }
            return LoadingScreen();
          },
        ),
      ),
    );
  }
}
