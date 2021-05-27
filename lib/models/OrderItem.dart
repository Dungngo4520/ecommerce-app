import 'package:flutter/material.dart';

class OrderItem {
  final String orderItemId;
  final String orderId;
  final String productId;
  final int amount;
  final Color color;

  OrderItem({
    required this.orderItemId,
    required this.orderId,
    required this.productId,
    required this.amount,
    required this.color,
  });
}
