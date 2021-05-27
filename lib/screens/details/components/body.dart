import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/details/components/color_dots.dart';
import 'package:ecommerce/screens/details/components/product_description.dart';
import 'package:ecommerce/screens/details/components/product_images.dart';
import 'package:ecommerce/screens/details/components/top_rounded_container.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  final Product product;
  final String heroTag;

  const Body({Key? key, required this.product, required this.heroTag}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    List<Cart> cartList = Provider.of<List<Cart>>(context);
    final firestore = Provider.of<DatabaseMethods>(context);
    ValueNotifier<int> currentAmount = Provider.of<ValueNotifier<int>>(context);
    ValueNotifier<Color> currentColor = Provider.of<ValueNotifier<Color>>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImages(
            product: widget.product,
            heroTag: widget.heroTag,
          ),
          TopRoundedCorner(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: widget.product,
                ),
                TopRoundedCorner(
                  color: cSecondaryColor.withOpacity(0.1),
                  child: Column(
                    children: [
                      ColorDots(product: widget.product, amount: cart.quantity),
                      TopRoundedCorner(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.1,
                            right: SizeConfig.screenWidth * 0.1,
                            top: getProportionateScreenWidth(5),
                            bottom: getProportionateScreenWidth(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ValueListenableBuilder<int>(
                                valueListenable: currentAmount,
                                builder: (context, amount, child) => Text(
                                  '${NumberFormat(',###').format(widget.product.price * amount)} ₫',
                                  style: TextStyle(
                                    color: cPrimaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.all(10),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(cPrimaryColor),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (cartList.any((element) =>
                                      element.productID == widget.product.id &&
                                      element.color == currentColor.value)) {
                                    Fluttertoast.showToast(msg: 'Item is already in cart');
                                  } else {
                                    if (currentAmount.value != 0) {
                                      firestore.updateCart(
                                          (cartList.length + 1).toString(),
                                          Cart(
                                            id: (cartList.length + 1).toString(),
                                            productID: widget.product.id,
                                            quantity: currentAmount.value,
                                            color: currentColor.value,
                                          ));
                                      Fluttertoast.showToast(msg: 'Cart Added');
                                    } else {
                                      Fluttertoast.showToast(msg: 'Please specify an amount');
                                    }
                                  }
                                },
                                child: Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getProportionateScreenWidth(18),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
