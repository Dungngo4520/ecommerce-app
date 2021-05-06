import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Product {
  final String id, title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  int price;
  final String ownerId;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.colors,
    this.rating = 0,
    required this.price,
    required this.ownerId,
  });

  Product copyWith({
    required String id,
    title,
    description,
    required int price,
    List<String>? images,
    List<Color>? colors,
    double? rating,
    String? ownerId,
  }) {
    return Product(
      id: id,
      title: title,
      description: description,
      price: price,
      images: images ?? this.images,
      colors: colors ?? this.colors,
      rating: rating ?? this.rating,
      ownerId: ownerId ?? this.ownerId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'title': title,
      'images': images,
      'colors': colors.map((x) => x.value).toList(),
      'rating': rating,
      'price': price,
      'ownerId': ownerId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      description: map['description'],
      images: List<String>.from(map['images']),
      colors: List<Color>.from(map['colors']?.map((x) => Color(x))),
      rating: map['rating'],
      price: map['price'],
      ownerId: map['ownerId'],
      id: map['id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(description: $description, images: $images, colors: $colors, rating: $rating, price: $price, ownerId: $ownerId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.description == description &&
        listEquals(other.images, images) &&
        listEquals(other.colors, colors) &&
        other.rating == rating &&
        other.price == price &&
        other.ownerId == ownerId;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        images.hashCode ^
        colors.hashCode ^
        rating.hashCode ^
        price.hashCode ^
        ownerId.hashCode;
  }
}

List<Product> demoProducts = [
  Product(
    id: 'product001',
    images: [
      "https://firebasestorage.googleapis.com/v0/b/ecommerce-mobile-c958d.appspot.com/o/ps4_console_white_1.png?alt=media&token=016db913-e5d6-423a-a3d8-435e7112e2f3",
      "https://firebasestorage.googleapis.com/v0/b/ecommerce-mobile-c958d.appspot.com/o/ps4_console_white_2.png?alt=media&token=47549a3c-493b-4b75-aaab-a4f5830a36bb",
      "https://firebasestorage.googleapis.com/v0/b/ecommerce-mobile-c958d.appspot.com/o/ps4_console_white_3.png?alt=media&token=943e4112-974a-4898-a937-f89c1c30d84b",
      "https://firebasestorage.googleapis.com/v0/b/ecommerce-mobile-c958d.appspot.com/o/ps4_console_white_4.png?alt=media&token=27052650-e2f3-47de-b12f-afcd8f402cad",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: 1500000,
    description:
        'The feel, shape, and sensitivity of the dual analog sticks and trigger buttons have been improved to provide a greater sense of control, no matter what you play The new multi touch and clickable touch pad on the face of the DualShock 4 Wireless Controller opens up worlds of new gameplay possibilities for both newcomers and veteran gamers The DualShock 4 Wireless Controller features a built in speaker and stereo headset jack, putting several new audio options in the player\'s hands The Dualshock 4 wireless controller can be easily recharged by plugging it into your PlayStation 4 system, even when in rest mode, or with any standard charger using a USB cable (type A to micro B sold separately)',
    rating: 4.8,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product002',
    images: [
      "https://firebasestorage.googleapis.com/v0/b/ecommerce-mobile-c958d.appspot.com/o/Image%20Popular%20Product%202.png?alt=media&token=d69454a4-c0ef-4cef-ab9f-4920cddff2bc",
    ],
    colors: [
      Color(0xFFCFD3CF),
      Colors.black,
    ],
    title: "Nike Flex Stride",
    price: 1150000,
    description:
        'The Nike Flex Stride Shorts have an all-new woven fabric and enhanced breathability in high-sweat areas.Their soft brief liner provides secure support where you need it most. Convenient pockets stash items when you\'re out on a run.This product is made from at least 50% recycled polyester fabric.This product is made from at least 50% recycled polyester fibres',
    rating: 4.1,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product003',
    images: [
      "https://firebasestorage.googleapis.com/v0/b/ecommerce-mobile-c958d.appspot.com/o/glap.png?alt=media&token=9e545d52-15e8-44a6-bc7c-40075fecc591",
    ],
    colors: [
      Color(0xFF24A4CC),
      Color(0xFF858B86),
      Color(0xFFBC2724),
    ],
    title: "Gloves XC Omega - Polygon",
    price: 842000,
    description:
        'Half finger gloves for cross-country (XC). Padding is soft and soft for cycling comfort. Velcro strap on wrist',
    rating: 4.1,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product000',
    images: [
      "https://firebasestorage.googleapis.com/v0/b/ecommerce-mobile-c958d.appspot.com/o/wireless%20headset.png?alt=media&token=a684ec71-59c9-4907-83ba-badb33d4b6ce",
    ],
    colors: [
      Colors.black,
    ],
    title: "Logitech G PRO X Gaming Headset",
    price: 460000,
    description:
        'PRO X joins a complete setup of gear developed in close collaboration with top esports pros. With our most advanced tech and focused design, nothing gets in the way of winning',
    rating: 4.1,
    ownerId: 'dungngo4520',
  ),
];
