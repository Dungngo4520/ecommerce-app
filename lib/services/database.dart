import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfoToDB(String userId, Map<String, dynamic> userInfo) async{
    return FirebaseFirestore.instance.collection('users').doc(userId).set(userInfo);
  }
}
