import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/ChatMessage.dart';
import 'package:ecommerce/models/ChatRoom.dart';
import 'package:ecommerce/models/Order.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/models/UserData.dart';

class DatabaseMethods {
  final String uid;

  DatabaseMethods({required this.uid});

  // User
  Future setUserInfoToDB(Map<String, dynamic> userInfo) async {
    return FirebaseFirestore.instance.collection('users').doc(uid).set(userInfo);
  }

  Stream<UserData> getCurrentUser() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((value) => UserData.fromMap({...?value.data()}));
  }

  Future<UserData> getUserById(String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) => UserData.fromMap({...?value.data()}));
  }

  Future<UserData> getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where(username, isEqualTo: username)
        .get()
        .then((value) => UserData.fromMap({...value.docs.first.data()}));
  }

  Future updateUser({String? displayName, String? phone, String? address, String? photoURL}) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      if (displayName != null) 'name': displayName,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (photoURL != null) 'photoURL': photoURL,
    });
  }

  // Product
  Future setProductToDB(String productId, Map<String, dynamic> productInfo) async {
    return FirebaseFirestore.instance.collection('products').doc(productId).set(productInfo);
  }

  Future<List<Product>> getProducts(int? limit) async {
    Future<QuerySnapshot<Map>> getProduct;
    if (limit != null && limit > 0)
      getProduct = FirebaseFirestore.instance.collection('products').limit(limit).get();
    else
      getProduct = FirebaseFirestore.instance.collection('products').get();

    return getProduct
        .then((value) => value.docs.map((e) => Product.fromMap({...e.data()})).toList());
  }

  Future<Product> getProductByID(String id) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .get()
        .then((value) => Product.fromMap({'id': value.id, ...?value.data()}));
  }

  // Cart
  Stream<List<Cart>> getCart() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('carts')
        .snapshots()
        .map((event) => event.docs.map((e) => Cart.fromMap({...e.data()})).toList());
  }

  Future<List<Product>> getProductListInCart(List<Cart> cartList) async {
    List<Product> productList = [];
    for (var i = 0; i < cartList.length; i++) {
      Product p = await getProductByID(cartList[i].productID);
      productList.add(p);
    }
    return productList;
  }

  Future updateCart(String cartId, Cart cart) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('carts')
        .doc(cartId)
        .set(cart.toMap());
  }

  Future updateCartAmount(String cartId, int amount) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('carts')
        .doc(cartId)
        .update({'quantity': amount});
  }

  Future deleteCart(String cartId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('carts')
        .doc(cartId)
        .delete();
  }

  Future clearCart() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('carts')
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        value.docs[i].reference.delete();
      }
    });
  }

  // Chat
  Stream<List<ChatRoom>> getChatRooms() {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .where('users', arrayContains: uid)
        .snapshots()
        .map((event) => event.docs.map((e) => ChatRoom.fromMap({...e.data()})).toList());
  }

  Future<ChatRoom> getChatRoomById(String chatroomId) async {
    return await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatroomId)
        .get()
        .then((value) => ChatRoom.fromMap({...?value.data()}));
  }

  Future createChatroom(String userId) async {
    if (userId != uid) {
      String idToFind = combineID(userId, uid);
      bool isExist = false;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chatrooms')
          .where('users', arrayContains: idToFind)
          .get();
      isExist = querySnapshot.size > 0;
      if (!isExist) {
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection('chatrooms').doc();
        await documentReference.set({
          'id': documentReference.id,
          'lastMessage': '',
          'lastMessageTimestamp': FieldValue.serverTimestamp(),
          'users': [uid, userId, idToFind],
        });
        return documentReference.id;
      }
      return querySnapshot.docs.first.id;
    }
  }

  Stream<List<ChatMessage>> getMessage(String chatroomId) {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('chatmessages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) => ChatMessage.fromMap({...e.data()})).toList());
  }

  Future addChatMessage(String chatroomId, String content, String senderId) async {
    DocumentReference doc = FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('chatmessages')
        .doc();
    await doc.set({
      'id': doc.id,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
      'senderId': senderId
    });
    await FirebaseFirestore.instance.collection('chatrooms').doc(chatroomId).update({
      'lastMessage': content,
      'lastMessageTimestamp': FieldValue.serverTimestamp(),
    });
  }

  String combineID(String a, String b) {
    return a.compareTo(b) == -1 ? '$a,$b' : '$b,$a';
  }

  // Order
  Future createOrder({
    required List<Cart> cartList,
    required String receiverName,
    required String receiverPhone,
    required String receiverAddress,
    required String paymentMethod,
    required double amount,
    required double discount,
  }) async {
    DocumentReference doc =
        FirebaseFirestore.instance.collection('users').doc(uid).collection('orders').doc();
    await doc.set({
      'id': doc.id,
      'buyerId': uid,
      'address': receiverAddress,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'paymentMethod': paymentMethod,
      'amount': amount,
      'discount': discount,
      'created': FieldValue.serverTimestamp(),
      'status': 'Verified',
    });
    CollectionReference itemsCol = doc.collection('items');
    for (var i = 0; i < cartList.length; i++) {
      await itemsCol.doc(cartList[i].id).set(cartList[i].toMap());
    }
  }

  Future<Order> getOrderbyId(String orderId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('orders')
        .doc(orderId)
        .get()
        .then((value) => Order.fromMap({...?value.data()}));
  }

  Stream<List<Order>> getOrders() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('orders')
        .snapshots()
        .map((event) => event.docs.map((e) => Order.fromMap({...e.data()})).toList());
  }

  Stream<List<Cart>> getOrderItems(String orderId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('orders')
        .doc(orderId)
        .collection('items')
        .snapshots()
        .map((event) => event.docs.map((e) => Cart.fromMap({...e.data()})).toList());
  }
}
