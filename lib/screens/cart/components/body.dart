import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/screens/cart/components/cart_item_card.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    List<Cart> cartList = Provider.of<List<Cart>>(context);
    final firestore = Provider.of<DatabaseMethods>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: ListView.separated(
        itemCount: cartList.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(cartList[index].productID),
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: cPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset('assets/icons/Trash.svg'),
                ],
              ),
            ),
            onDismissed: (direction) {
              firestore.deleteCart(cartList[index].id);
            },
            child: CartItemCard(cart: cartList[index]),
          ),
        ),
      ),
    );
  }
}
