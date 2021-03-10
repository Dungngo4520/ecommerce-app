import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: cSecondaryColor.withOpacity(0.1)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              height: 50,
              width: 50,
              child: Image.asset(product.images[0]),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$" + product.price.toString() + ' - ',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: cPrimaryColor),
                    ),
                    Text(product.rating.toString()),
                    SvgPicture.asset('assets/icons/Star Icon.svg'),
                  ],
                ),
              ],
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                "Edit",
                textAlign: TextAlign.end,
              ),
              style: TextButton.styleFrom(primary: cPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
