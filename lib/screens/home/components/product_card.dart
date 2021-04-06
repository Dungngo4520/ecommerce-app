import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1.02,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  final double width, aspectRatio;
  final Product product;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: getProportionateScreenWidth(width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                    decoration: BoxDecoration(
                      color: cSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(product.images[0]),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                product.title,
                style: TextStyle(color: Colors.black87),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price}',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: cPrimaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: EdgeInsets.all(
                        getProportionateScreenWidth(8),
                      ),
                      width: getProportionateScreenWidth(28),
                      height: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: product.isFavorite
                            ? cPrimaryColor.withOpacity(0.15)
                            : cSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/Heart Icon_2.svg',
                        color: product.isFavorite
                            ? cPrimaryColor
                            : cSecondaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
