import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String buyerId;
  final String receiverName;
  final String receiverPhone;
  final String address;
  final String paymentMethod;
  final double amount;
  final double discount;
  final Timestamp created;
  final String status;

  Order({
    required this.id,
    required this.buyerId,
    required this.receiverName,
    required this.receiverPhone,
    required this.address,
    required this.paymentMethod,
    required this.amount,
    required this.discount,
    required this.created,
    required this.status,
  });

  Order copyWith({
    String? id,
    String? buyerId,
    String? receiverName,
    String? receiverPhone,
    String? address,
    String? paymentMethod,
    double? amount,
    double? discount,
    Timestamp? created,
    String? status,
  }) {
    return Order(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amount: amount ?? this.amount,
      discount: discount ?? this.discount,
      created: created ?? this.created,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buyerId': buyerId,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'address': address,
      'paymentMethod': paymentMethod,
      'amount': amount,
      'discount': discount,
      'created': created,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      buyerId: map['buyerId'],
      receiverName: map['receiverName'],
      receiverPhone: map['receiverPhone'],
      address: map['address'],
      paymentMethod: map['paymentMethod'],
      amount: map['amount'],
      discount: map['discount'],
      created: map['created'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, buyerId: $buyerId, receiverName: $receiverName, receiverPhone: $receiverPhone, address: $address, paymentMethod: $paymentMethod, amount: $amount, discount: $discount, created: $created, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.buyerId == buyerId &&
        other.receiverName == receiverName &&
        other.receiverPhone == receiverPhone &&
        other.address == address &&
        other.paymentMethod == paymentMethod &&
        other.amount == amount &&
        other.discount == discount &&
        other.created == created &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        buyerId.hashCode ^
        receiverName.hashCode ^
        receiverPhone.hashCode ^
        address.hashCode ^
        paymentMethod.hashCode ^
        amount.hashCode ^
        discount.hashCode ^
        created.hashCode ^
        status.hashCode;
  }
}
