import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';

const UNIQ_ID = 0,
    PRODUCT_NAME = 1,
    BRAND_NAME = 2,
    ASIN = 3,
    CATEGORY = 4,
    UPC_EAN_CODE = 5,
    LIST_PRICE = 6,
    SELLING_PRICE = 7,
    QUANTITY = 8,
    MODEL_NUMBER = 9,
    ABOUT_PRODUCT = 10,
    PRODUCT_SPECIFICATION = 11,
    TECHNICAL_DETAILS = 12,
    SHIPPING_WEIGHT = 13,
    PRODUCT_DIMENSIONS = 14,
    IMAGE = 15,
    VARIANTS = 16,
    SKU = 17,
    PRODUCT_URL = 18,
    STOCK = 19,
    PRODUCT_DETAILS = 20,
    DIMENSIONS = 21,
    COLOR = 22,
    INGREDIENTS = 23,
    DIRECTION_TO_USE = 24,
    IS_AMAZON_SELLER = 25,
    SIZE_QUANTITY_VARIANT = 26,
    PRODUCT_DESCRIPTION = 27;

Future<void> main() async {
  final input = new File('lib\\sample_product.csv').openRead();
  final fileData =
      await input.transform(utf8.decoder).transform(new CsvToListConverter(eol: "\n")).toList();

  //first 10 title
  for (int i = 1; i <= 10; i++) {
    var price = double.parse(fileData[i][SELLING_PRICE].toString().substring(1)) * 22935.50;
    price = (price / 1000).round() * 1000;
    print('${NumberFormat(',###').format(price)}');
  }
}
