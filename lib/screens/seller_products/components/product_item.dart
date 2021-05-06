import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:flutter/material.dart';

class ProductItems extends StatelessWidget {
  const ProductItems({
    Key? key,
    required this.product,
  }) : super(key: key);

  final List<Product> product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          dataRowHeight: 50,
          rows: <DataRow>[
            ...List.generate(
              product.length,
              (index) => DataRow(
                cells: [
                  DataCell(
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      height: 50,
                      width: 50,
                      child: Image.network(product[index].images[0]),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 110,
                      child: Text(
                        product[index].title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        ...List.generate(
                          product[index].colors.length,
                          (index2) => Container(
                            height: 12,
                            width: 12,
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: cSecondaryColor.withOpacity(0.2),
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(2),
                              color: product[index].colors[index2],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  DataCell(
                    Text(
                      "\$" + product[index].price.toString(),
                      style: TextStyle(
                        color: cPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          columns: [
            DataColumn(label: Text('Image')),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Color")),
            DataColumn(label: Text("Price")),
          ],
        ),
      ),
    );
  }
}
