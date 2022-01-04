import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset('assets/images/sale.jpg'),
      //  Text.rich(
      //   TextSpan(
      //     text: 'A New Year Surprise\n',
      //     style: TextStyle(color: Colors.white),
      //     children: [
      //       TextSpan(
      //         text: 'Cashback 20%',
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
