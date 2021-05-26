import 'package:ecommerce/constants.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> choice = Provider.of<ValueNotifier<int>>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            bottom: getProportionateScreenHeight(10),
          ),
          child: Text('PAYMENT METHOD'),
        ),
        Column(
          children: [
            InkWell(
              onTap: () {
                choice.value = 1;
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                  horizontal: getProportionateScreenWidth(20),
                ),
                decoration: BoxDecoration(color: cSecondaryColor.withAlpha(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          'https://img.mservice.io/momo-payment/icon/images/logo512.png',
                          height: getProportionateScreenHeight(40),
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
                        SizedBox(width: getProportionateScreenWidth(10)),
                        Text('MoMo E-Wallet'),
                      ],
                    ),
                    if (choice.value == 1)
                      Icon(
                        Icons.check_rounded,
                        size: getProportionateScreenHeight(20),
                      ),
                  ],
                ),
              ),
            ),
            Divider(thickness: 1, height: 0),
            InkWell(
              onTap: () {
                choice.value = 2;
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(15),
                  horizontal: getProportionateScreenWidth(20),
                ),
                decoration: BoxDecoration(color: cSecondaryColor.withAlpha(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Direct'),
                    if (choice.value == 2)
                      Icon(
                        Icons.check_rounded,
                        size: getProportionateScreenHeight(20),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
