import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/details_screen.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<DatabaseMethods>(context);
    return StreamBuilder<Product>(
      stream: Stream.fromFuture(firestore.getProductByID(cart.productID)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(),
                    settings: RouteSettings(
                      arguments: ProductDetailsAgrument(
                        product: snapshot.data!,
                        heroTag: snapshot.data!.id + 'cart',
                      ),
                    ),
                  ),
                ),
                child: SizedBox(
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
                        snapshot.data!.images[0],
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
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.title,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text('Color: '),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: cPrimaryColor,
                            ),
                          ),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cart.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: '${NumberFormat(',###').format(snapshot.data!.price)} ₫',
                            style: TextStyle(
                              color: cPrimaryColor,
                            ),
                            children: [
                              TextSpan(
                                text: ' x${cart.quantity}',
                                style: TextStyle(color: cTextColor),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              child: Icon(
                                Icons.add_rounded,
                                color: cPrimaryColor,
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                                minimumSize: MaterialStateProperty.all(Size.zero),
                                overlayColor:
                                    MaterialStateProperty.all(cPrimaryColor.withOpacity(0.1)),
                                shape: MaterialStateProperty.all(CircleBorder()),
                              ),
                              onPressed: () {
                                firestore.updateCartAmount(cart.id, cart.quantity + 1);
                              },
                            ),
                            TextButton(
                              child: Icon(
                                Icons.remove_rounded,
                                color: cPrimaryColor,
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                                minimumSize: MaterialStateProperty.all(Size.zero),
                                overlayColor:
                                    MaterialStateProperty.all(cPrimaryColor.withOpacity(0.1)),
                                shape: MaterialStateProperty.all(CircleBorder()),
                              ),
                              onPressed: () {
                                if (cart.quantity > 1)
                                  firestore.updateCartAmount(cart.id, cart.quantity - 1);
                                else
                                  Fluttertoast.showToast(msg: 'Swipe left to delete');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}
