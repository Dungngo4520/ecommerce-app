import 'package:ecommerce/enum.dart';
import 'package:ecommerce/models/OrderItem.dart';
import 'package:ecommerce/models/User.dart';
import 'package:flutter/material.dart';

class Order {
  final String orderId, buyerId, sellerId, address;
  final DateTime created;
  final List<OrderItem> orderItems;
  final OrderState status;

  Order({
    @required this.sellerId,
    @required this.orderId,
    @required this.address,
    @required this.created,
    @required this.status,
    @required this.orderItems,
    @required this.buyerId,
  });
}

List<Order> demoSellerOrders = [
  Order(
    orderId: 'order001',
    sellerId: 'user000',
    buyerId: 'user001',
    orderItems: [
      OrderItem(
        productId: 'product001',
        amount: 3,
        color: Color(0xFFF6625E),
        orderId: 'order001',
        orderItemId: 'orderItem001',
      ),
    ],
    status: OrderState.Shipped,
    address: demoBuyer.address,
    created: DateTime.now(),
  ),
  Order(
    orderId: 'order002',
    sellerId: 'user000',
    buyerId: 'user001',
    orderItems: [
      OrderItem(
        productId: 'product002',
        amount: 2,
        color: Color(0xFF836DB8),
        orderId: 'order002',
        orderItemId: 'orderItem002',
      ),
      OrderItem(
        productId: 'product003',
        amount: 1,
        color: Color(0xFF836DB8),
        orderId: 'order002',
        orderItemId: 'orderItem003',
      ),
    ],
    status: OrderState.Verifying,
    address: demoBuyer.address,
    created: DateTime.now(),
  ),
  Order(
    orderId: 'order003',
    sellerId: 'user000',
    buyerId: 'user001',
    orderItems: [
      OrderItem(
        productId: 'product001',
        amount: 3,
        color: Color(0xFFDECB9C),
        orderId: 'order003',
        orderItemId: 'orderItem004',
      ),
      OrderItem(
        productId: 'product002',
        amount: 3,
        color: Color(0xFFDECB9C),
        orderId: 'order003',
        orderItemId: 'orderItem005',
      ),
    ],
    status: OrderState.Shipping,
    address: demoBuyer.address,
    created: DateTime.now(),
  ),
  Order(
    orderId: 'order004',
    sellerId: 'user000',
    buyerId: 'user001',
    orderItems: [
      OrderItem(
        productId: 'product000',
        amount: 3,
        color: Colors.white,
        orderId: 'order004',
        orderItemId: 'orderItem006',
      ),
    ],
    status: OrderState.Cancelled,
    address: demoBuyer.address,
    created: DateTime.now(),
  ),
  Order(
    orderId: 'order005',
    sellerId: 'user000',
    buyerId: 'user001',
    orderItems: [
      OrderItem(
        productId: 'product001',
        amount: 3,
        color: Colors.white,
        orderId: 'order005',
        orderItemId: 'orderItem007',
      ),
    ],
    status: OrderState.Shipped,
    address: demoBuyer.address,
    created: DateTime.now(),
  ),
  Order(
    orderId: 'order006',
    sellerId: 'user000',
    buyerId: 'user001',
    orderItems: [
      OrderItem(
        productId: 'product001',
        amount: 1,
        color: Color(0xFFDECB9C),
        orderId: 'order006',
        orderItemId: 'orderItem008',
      ),
      OrderItem(
        productId: 'product003',
        amount: 3,
        color: Color(0xFFF6625E),
        orderId: 'order006',
        orderItemId: 'orderItem009',
      ),
      OrderItem(
        productId: 'product002',
        amount: 4,
        color: Color(0xFFF6625E),
        orderId: 'order006',
        orderItemId: 'orderItem010',
      ),
      OrderItem(
        productId: 'product000',
        amount: 5,
        color: Colors.white,
        orderId: 'order006',
        orderItemId: 'orderItem011',
      ),
    ],
    status: OrderState.Shipped,
    address: demoBuyer.address,
    created: DateTime.now(),
  ),
];
