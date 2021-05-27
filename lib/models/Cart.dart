import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ecommerce/models/Product.dart';

class Cart {
  final String id;
  final String productID;
  final int quantity;
  final Color color;

  Cart({
    required this.id,
    required this.productID,
    required this.quantity,
    required this.color,
  });

  Cart copyWith({
    String? id,
    String? productID,
    int? quantity,
    Color? color,
  }) {
    return Cart(
      id: id ?? this.id,
      productID: productID ?? this.productID,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productID': productID,
      'quantity': quantity,
      'color': color.value,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      productID: map['productID'],
      quantity: map['quantity'],
      color: Color(map['color']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cart(id: $id, productID: $productID, quantity: $quantity, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart &&
        other.id == id &&
        other.productID == productID &&
        other.quantity == quantity &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^ productID.hashCode ^ quantity.hashCode ^ color.hashCode;
  }
}

List<Cart> demoCarts = [
  Cart(id: 'cart1', productID: demoProducts[0].id, quantity: 2, color: demoProducts[0].colors[0]),
  Cart(id: 'cart2', productID: demoProducts[1].id, quantity: 1, color: demoProducts[1].colors[0]),
  Cart(id: 'cart3', productID: demoProducts[3].id, quantity: 1, color: demoProducts[3].colors[0]),
];
