import 'package:ecommerce/screens/my_account/my_account_screen.dart';
import 'package:ecommerce/screens/order_list/order_list_screen.dart';
import 'package:ecommerce/screens/profile/components/profile_menu.dart';
import 'package:ecommerce/screens/profile/components/profile_picture.dart';
import 'package:ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthMethods>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          ProfilePicture(changeable: false),
          SizedBox(height: 20),
          ProfileMenu(
            text: 'My Profile',
            icon: 'assets/icons/User Icon.svg',
            onPressed: () {
              Navigator.pushNamed(context, MyAccountScreen.route);
            },
          ),
          ProfileMenu(
            text: 'My Order',
            icon: 'assets/icons/Cart Icon.svg',
            onPressed: () {
              Navigator.pushNamed(context, OrderListScreen.route);
            },
          ),
          // ProfileMenu(
          //   text: 'My Shop',
          //   icon: 'assets/icons/Shop Icon.svg',
          //   onPressed: () => Navigator.pushNamed(context, SellerProductsScreen.route),
          // ),
          // ProfileMenu(
          //   text: 'Settings',
          //   icon: 'assets/icons/Settings.svg',
          //   onPressed: () {},
          // ),
          ProfileMenu(
            text: 'About',
            icon: 'assets/icons/Question mark.svg',
            onPressed: () => showAboutDialog(
              context: context,
              applicationVersion: '1.0',
              applicationLegalese: "This is a demo product",
            ),
          ),
          ProfileMenu(
            text: 'Log Out',
            icon: 'assets/icons/Log out.svg',
            onPressed: () {
              auth.signOut(context).then((_) {
                Navigator.pushReplacementNamed(context, SignInScreen.route);
              });
            },
          ),
          // ProfileMenu(
          //   text: 'Upload',
          //   icon: 'assets/icons/Check mark rounde.svg',
          //   onPressed: () async {
          //     print('Loading');
          //     final input = await rootBundle.loadString('assets/sample_product.csv');
          //     final data = new CsvToListConverter(eol: "\n").convert(input);
          //     print('Processing');
          //     for (int i = 2; i < data.length; i++) {
          //       // print('Product Id: ${data[i][UNIQ_ID]}');
          //       // print('Product Title: ${data[i][PRODUCT_NAME]}');
          //       // print(
          //       //     'Product Description: ${data[i][ABOUT_PRODUCT].toString().split("|").join("\n")}');
          //       // print('Image URL: ${data[i][IMAGE].toString().split("|")}');
          //       // print('Rating: ${(4 + Random().nextDouble()).toStringAsFixed(1)}');
          //       // print('Color: ${[Colors.white.toString()]}');
          //       String m =
          //           RegExp(r'\d+(,*\d*\.*\d*)').firstMatch(data[i][SELLING_PRICE])?.group(0) ?? "1";
          //       var price = double.parse(m.replaceAll(',', '')) * 22935.50;
          //       price = ((price / 1000).round() * 1000);
          //       print('Product $i');
          //       await AlgoliaSearch().sendData(new Product(
          //           id: data[i][UNIQ_ID],
          //           title: data[i][PRODUCT_NAME],
          //           description: data[i][ABOUT_PRODUCT].toString().split("|").join("\n"),
          //           images: data[i][IMAGE].toString().split("|"),
          //           colors: [Colors.white],
          //           price: price.toInt(),
          //           rating: (40 + Random.secure().nextInt(10)) / 10.0,
          //           ownerId: user.id));
          //       // print('Price: ${price.toInt()}');
          //       // print('----------------------');
          //       // await firestore.createProduct(new Product(
          //       //     id: data[i][UNIQ_ID],
          //       //     title: data[i][PRODUCT_NAME],
          //       //     description: data[i][ABOUT_PRODUCT].toString().split("|").join("\n"),
          //       //     images: data[i][IMAGE].toString().split("|"),
          //       //     colors: [Colors.white],
          //       //     price: price.toInt(),
          //       //     rating: (40+Random.secure().nextInt(10))/10.0,
          //       //     ownerId: user.id));
          //     }
          //     print('Done');
          //   },
          // ),
        ],
      ),
    );
  }
}
