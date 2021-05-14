import 'dart:convert';

import 'package:ecommerce/models/Product.dart';

class Cart {
  final String productID;
  final int quantity;

  Cart({
    required this.productID,
    required this.quantity,
  });

  Cart copyWith({
    String? productID,
    int? quantity,
  }) {
    return Cart(
      productID: productID ?? this.productID,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      productID: map['productID'],
      quantity: map['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(productID: $productID, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart &&
        other.productID == productID &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => productID.hashCode ^ quantity.hashCode;
}

List<Cart> demoCarts = [
  Cart(productID: demoProducts[0].id, quantity: 2),
  Cart(productID: demoProducts[1].id, quantity: 1),
  Cart(productID: demoProducts[3].id, quantity: 1),
];
