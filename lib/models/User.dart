import 'package:ecommerce/models/Order.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:flutter/material.dart';

class User {
  final String id, email, name, phone, address;
  final List<String> orderIds, sellerOrderIds, sellerProductIds;

  User({
    @required this.sellerProductIds,
    @required this.orderIds,
    @required this.sellerOrderIds,
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.phone,
    @required this.address,
  });
}

User demoSeller = User(
  address: 'Cau Giay, Ha Noi',
  email: 'user1@mail.com',
  id: 'user000',
  name: 'User 0',
  phone: '0123456789',
  orderIds: [],
  sellerOrderIds: [
    demoSellerOrders[0].orderId,
    demoSellerOrders[1].orderId,
    demoSellerOrders[2].orderId,
    demoSellerOrders[3].orderId,
    demoSellerOrders[4].orderId,
    demoSellerOrders[5].orderId,
  ],
  sellerProductIds: [
    demoProducts[0].id,
    demoProducts[1].id,
    demoProducts[2].id,
    demoProducts[3].id,
  ],
);
User demoBuyer = User(
  address: 'Quan 1, TP.HCM',
  email: 'user2@mail.com',
  id: 'user001',
  name: 'User 1',
  phone: '0987654321',
  orderIds: [
    demoSellerOrders[0].orderId,
    demoSellerOrders[1].orderId,
    demoSellerOrders[2].orderId,
    demoSellerOrders[3].orderId,
    demoSellerOrders[4].orderId,
    demoSellerOrders[5].orderId,
  ],
  sellerOrderIds: [],
  sellerProductIds: [],
);
