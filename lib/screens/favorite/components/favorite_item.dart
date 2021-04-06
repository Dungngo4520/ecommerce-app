import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            height: getProportionateScreenWidth(100),
            width: getProportionateScreenWidth(100),
            child: Image.asset(product.images[0]),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  product.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "\$" + product.price.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: cPrimaryColor),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: cPrimaryColor,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
