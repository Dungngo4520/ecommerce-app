import 'package:ecommerce/enum.dart';
import 'package:ecommerce/models/OrderItem.dart';

class Order {
  final String orderId;
  final String buyerId;
  final String sellerId;
  final String address;
  final DateTime created;
  final List<OrderItem> orderItems;
  final OrderState status;

  Order({
    required this.sellerId,
    required this.orderId,
    required this.address,
    required this.created,
    required this.status,
    required this.orderItems,
    required this.buyerId,
  });
}
