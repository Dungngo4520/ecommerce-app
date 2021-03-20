import 'package:flutter/material.dart';

class OrderItem {
  final String orderItemId, orderId, productId;
  final int amount;
  final Color color;

  OrderItem({
    @required this.orderItemId,
    @required this.orderId,
    @required this.productId,
    @required this.amount,
    @required this.color,
  });
}
