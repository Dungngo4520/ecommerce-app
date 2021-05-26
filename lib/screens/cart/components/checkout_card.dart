import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/screens/payment/payment_screen.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckOutCard extends StatefulWidget {
  const CheckOutCard({
    Key? key,
  }) : super(key: key);

  @override
  _CheckOutCardState createState() => _CheckOutCardState();
}

class _CheckOutCardState extends State<CheckOutCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Cart> cartList = Provider.of<List<Cart>>(context);
    final firestore = Provider.of<DatabaseMethods>(context);
    return FutureBuilder<List<Product>>(
      future: firestore.getProductListInCart(cartList),
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.data!.isNotEmpty) {
          int amount = 0;
          for (var i = 0; i < cartList.length; i++) {
            amount += cartList[i].quantity * snapshot.data![i].price;
          }
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
              vertical: getProportionateScreenWidth(30),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -15),
                  blurRadius: 20,
                  color: cSecondaryColor.withOpacity(0.1),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        decoration: BoxDecoration(
                          color: cSecondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SvgPicture.asset('assets/icons/receipt.svg'),
                      ),
                      Spacer(),
                      Text('Add voucher code'),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: cTextColor,
                      )
                    ],
                  ),
                  SizedBox(height: getProportionateScreenWidth(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Total:\n',
                          children: [
                            TextSpan(
                              text: '${NumberFormat(',###').format(amount)} ₫',
                              style: TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(190),
                        child: DefaultButton(
                          text: 'Check Out',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(amount: amount.toDouble()),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return Center(child: Text('Do some shopping and comeback.'));
      },
    );
  }
}
