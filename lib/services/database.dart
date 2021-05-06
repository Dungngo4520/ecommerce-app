import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future setUserInfoToDB(String userId, Map<String, dynamic> userInfo) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userInfo);
  }

  Future setProductToDB(
      String productId, Map<String, dynamic> productInfo) async {
    return FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .set(productInfo);
  }

  Future<QuerySnapshot> getProducts(int? limit) async {
    if (limit! > 0)
      return FirebaseFirestore.instance
          .collection('products')
          .limit(limit)
          .get();
    else
      return FirebaseFirestore.instance.collection('products').get();
  }

  Future<Stream<QuerySnapshot>> getUserByUsername(String username) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where(username, isEqualTo: username)
        .snapshots();
  }
}
