import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/screens/order/order_screen.dart';
import 'package:ecommerce/screens/payment/component/payment_method.dart';
import 'package:ecommerce/screens/payment/component/payment_summary.dart';
import 'package:ecommerce/services/momo_service_helper.dart';
import 'package:ecommerce/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  MomoServiceHelper momo = MomoServiceHelper();
  @override
  void initState() {
    super.initState();
    momo.momoInit();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double amount = Provider.of<double>(context);
    ValueNotifier<int> method = Provider.of<ValueNotifier<int>>(context);
    final user = Provider.of<User>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentSummary(),
        SizedBox(height: getProportionateScreenHeight(30)),
        PaymentMethod(),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(30),
              vertical: getProportionateScreenWidth(30)),
          child: DefaultButton(
              text: 'Place Order',
              onPressed: () {
                if (method.value == 1) {
                  momo.openMomo(
                    amount: amount,
                    description: "Thanh toán đơn hàng",
                    username: user.email,
                    orderId: randomAlpha(20),
                    orderLabel: "Thanh toán đơn hàng",
                    extra: "",
                    fee: 0,
                  );
                }
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderScreen(),
                  ),
                );
              }),
        )
      ],
    );
  }
}
