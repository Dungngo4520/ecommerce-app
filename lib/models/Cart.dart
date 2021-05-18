import 'dart:convert';

import 'package:ecommerce/models/Product.dart';

class Cart {
  final String id;
  final String productID;
  final int quantity;

  Cart({
    required this.id,
    required this.productID,
    required this.quantity,
  });

  Cart copyWith({
    String? id,
    String? productID,
    int? quantity,
  }) {
    return Cart(
      id: id ?? this.id,
      productID: productID ?? this.productID,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productID': productID,
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      productID: map['productID'],
      quantity: map['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(id: $id, productID: $productID, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Cart &&
      other.id == id &&
      other.productID == productID &&
      other.quantity == quantity;
  }

  @override
  int get hashCode => id.hashCode ^ productID.hashCode ^ quantity.hashCode;
}

List<Cart> demoCarts = [
  Cart(id: 'cart1', productID: demoProducts[0].id, quantity: 2),
  Cart(id: 'cart2', productID: demoProducts[1].id, quantity: 1),
  Cart(id: 'cart3', productID: demoProducts[3].id, quantity: 1),
];
