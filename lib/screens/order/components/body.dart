import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Order.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/models/UserData.dart';
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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: FutureBuilder<Order>(
            future: firestore.getOrderbyId('Ue3WrUjiiDOQrGgqk33n'),
            builder: (context, order) {
              if (order.hasData) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
                          child: Icon(
                            Icons.receipt_outlined,
                            color: cPrimaryColor,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order ID: ${order.data!.id}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text('Order Date: '),
                                Text(DateFormat('kk:mm - dd-MM-yyyy')
                                    .format(order.data!.created.toDate())),
                              ],
                            ),
                            Text(
                              order.data!.status,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: cPrimaryColor,
                            )),
                        Container(
                          width: SizeConfig.screenWidth - getProportionateScreenWidth(70),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Address',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(order.data!.receiverName),
                              Text(order.data!.receiverPhone),
                              Text(order.data!.address),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
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
                              stream: firestore.getOrderItems(order.data!.id),
                              builder: (context, listCart) {
                                if (listCart.hasData) {
                                  return Column(
                                    children: [
                                      ...List.generate(
                                        listCart.data!.length,
                                        (index) {
                                          return FutureBuilder<Product>(
                                            future: firestore
                                                .getProductByID(listCart.data![index].productID),
                                            builder: (context, product) {
                                              if (product.hasData) {
                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: getProportionateScreenHeight(5)),
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
                                                              color:
                                                                  cSecondaryColor.withOpacity(0.1),
                                                              borderRadius:
                                                                  BorderRadius.circular(15),
                                                            ),
                                                            child: Image.network(
                                                              product.data!.images[0],
                                                              errorBuilder:
                                                                  (context, error, stackTrace) =>
                                                                      Icon(Icons.image),
                                                              loadingBuilder: (context, child,
                                                                  loadingProgress) {
                                                                if (loadingProgress == null) {
                                                                  return child;
                                                                }
                                                                return Center(
                                                                  child: CircularProgressIndicator(
                                                                    color: cPrimaryColor,
                                                                    value: loadingProgress
                                                                                .expectedTotalBytes !=
                                                                            null
                                                                        ? loadingProgress
                                                                                .cumulativeBytesLoaded /
                                                                            loadingProgress
                                                                                .expectedTotalBytes!
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
                                                            getProportionateScreenWidth(150),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              product.data!.title,
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      getProportionateScreenWidth(
                                                                          14)),
                                                            ),
                                                            FutureBuilder<UserData>(
                                                              future: firestore.getUserById(
                                                                  product.data!.ownerId),
                                                              builder: (context, snapshot) {
                                                                if (snapshot.hasData) {
                                                                  return Text(
                                                                    'Provided by Dung Ngo',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            getProportionateScreenWidth(
                                                                                12)),
                                                                  );
                                                                }
                                                                return LoadingScreen();
                                                              },
                                                            ),
                                                            Text(
                                                              '${NumberFormat(',###').format(product.data!.price)} ₫ x${listCart.data![index].quantity}',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
                          child: Icon(
                            Icons.payment_outlined,
                            color: cPrimaryColor,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment Method',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'Paid ${order.data!.paymentMethod == 'Momo' ? 'with Momo E-Wallet' : 'Directly'}'),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Amount'),
                          Text('${NumberFormat(',###').format(order.data!.amount)} ₫'),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Discount'),
                          Text('-${NumberFormat(',###').format(order.data!.discount)} ₫'),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${NumberFormat(',###').format(order.data!.amount - order.data!.discount)} ₫',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: getProportionateScreenWidth(16)),
                              ),
                              Text(
                                'Included VAT',
                                style: TextStyle(fontSize: getProportionateScreenWidth(13)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return LoadingScreen();
            },
          ),
        ),
      ),
    );
  }
}
