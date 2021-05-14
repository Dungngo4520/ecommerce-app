import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/Product.dart';

class DatabaseMethods {
  final String uid;

  DatabaseMethods({required this.uid});

  Future setUserInfoToDB(Map<String, dynamic> userInfo) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userInfo);
  }

  Stream<QuerySnapshot> getUserByUsername(String username) {
    return FirebaseFirestore.instance
        .collection('users')
        .where(username, isEqualTo: username)
        .snapshots();
  }

  Future setProductToDB(
      String productId, Map<String, dynamic> productInfo) async {
    return FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .set(productInfo);
  }

  Future<List<Product>> getProducts(int? limit) async {
    Future<QuerySnapshot> getProduct;
    if (limit! > 0)
      getProduct =
          FirebaseFirestore.instance.collection('products').limit(limit).get();
    else
      getProduct = FirebaseFirestore.instance.collection('products').get();

    return getProduct.then((value) => value.docs
        .map((e) => Product.fromMap({'id': e.id, ...e.data()}))
        .toList());
  }

  Future<Product> getProductByID(String id) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .get()
        .then((value) => Product.fromMap({'id': value.id, ...?value.data()}));
  }

  Stream<List<Cart>> getCart() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('carts')
        .snapshots()
        .map((event) => event.docs.map((e) => Cart.fromMap(e.data())).toList());
  }

  Future<List<Product>> getProductListInCart(List<Cart> cartList) async {
    List<Product> productList = [];
    for (var i = 0; i < cartList.length; i++) {
      Product p = await getProductByID(cartList[i].productID);
      productList.add(p);
    }
    return productList;
  }

  Future addToCart(Cart cart) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('carts')
        .add(cart.toMap());
  }

  Future updateCartByUserID(Cart cart) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('carts')
        .doc()
        .set(cart.toMap());
  }
}
