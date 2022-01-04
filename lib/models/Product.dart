import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String ownerId;
  final int price;
  final double rating;
  final List<String> images;
  final List<Color> colors;

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
    String? id,
    String? title,
    String? description,
    List<String>? images,
    List<Color>? colors,
    double? rating,
    int? price,
    String? ownerId,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      colors: colors ?? this.colors,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      ownerId: ownerId ?? this.ownerId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'images': images,
      'colors': colors.map((x) => x.value).toList(),
      'rating': rating,
      'price': price,
      'ownerId': ownerId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      images: List<String>.from(map['images']),
      colors: List<Color>.from(map['colors']?.map((x) => Color(x))),
      rating: map['rating'].toDouble(),
      price: map['price'],
      ownerId: map['ownerId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, images: $images, colors: $colors, rating: $rating, price: $price, ownerId: $ownerId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.images, images) &&
        listEquals(other.colors, colors) &&
        other.rating == rating &&
        other.price == price &&
        other.ownerId == ownerId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        images.hashCode ^
        colors.hashCode ^
        rating.hashCode ^
        price.hashCode ^
        ownerId.hashCode;
  }
}

List<Product> demoProducts = [
  Product(
    id: 'product004',
    title: "Apple AirPods with Charging Case (Wired)",
    images: [
      "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MV7N2?wid=1144&hei=1144&fmt=jpeg&qlt=95&.v=1551489688005",
      'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MV7N2_AV1?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1551489684370',
      'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MV7N2_AV2?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1551489686690',
      'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MV7N2_AV3?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1552508263186',
      'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MV7N2_AV4_GEO_US?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1604078472000',
    ],
    colors: [
      Colors.white,
    ],
    price: 3657795,
    description:
        'Automatically on, automatically connected\nEasy setup for all your Apple devices\nQuick access to Siri by saying \“Hey Siri\”\nDouble-tap to play or skip forward\nNew Apple H1 headphone chip delivers faster wireless connection to your devices',
    rating: 5.0,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product005',
    title: "Blue 24‑inch iMac with Apple M1 chip",
    description:
        'Apple M1 chip with 8-core CPU with 4 performance cores and 4 efficiency cores, 8-core GPU, and 16-core Neural Engine\n8GB unified memory\n256GB SSD storage\nTwo Thunderbolt / USB 4 ports\nTwo USB 3 ports\nGigabit Ethernet\nMagic Mouse\nMagic Keyboard with Touch ID - US English',
    images: [
      "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/imac-24-touch-id-blue-gallery-1?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1617486478000",
      'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/imac-24-touch-id-blue-gallery-2?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1617741434000',
      'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/imac-24-touch-id-blue-gallery-3?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1617741419000',
    ],
    colors: [
      Color(0xff2A5079),
    ],
    price: 34484495,
    rating: 5.0,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product006',
    title:
        "Seagate Portable 2TB External Hard Drive Portable HDD – USB 3.0 for PC, Mac, PS4, & Xbox - 1-Year Rescue Service (STGX2000400)",
    images: [
      "https://m.media-amazon.com/images/I/71e9XKg+JLL._AC_SL1500_.jpg",
      'https://m.media-amazon.com/images/I/81pBFmbCQoL._AC_SL1500_.jpg',
      'https://m.media-amazon.com/images/I/91fPAhITwOL._AC_SL1500_.jpg',
      'https://m.media-amazon.com/images/I/91Clp7RnFiL._AC_SL1500_.jpg',
      'https://m.media-amazon.com/images/I/81PMJufY6QL._AC_SL1500_.jpg',
      'https://m.media-amazon.com/images/I/71bVsXVwx+L._AC_SL1500_.jpg',
    ],
    colors: [
      Colors.black,
      Color(0xffDADADA),
    ],
    price: 1450000,
    description:
        'Store and access photos and files with Seagate One Touch, an on-the-go USB drive for Windows and Mac (Reformatting may be required for use with Time Machine)\nThe perfect compliment to personal aesthetic, this portable external hard drive features a minimalist brushed metal enclosure\nGreat as a laptop hard drive or PC hard drive, simply plug in via USB 3.0 to back up with a single click or schedule automatic daily, weekly, or monthly backups\nEdit, manage, and share photos with a 1 year complimentary subscription to Mylio Create and a 4 month membership to Adobe Creative Cloud Photography plan. (Must redeem within 1 year of drive registration. Not available in all countries.)\nEnjoy long-term peace of mind with the included 2 year limited warranty and 2 year rescue data recovery services',
    rating: 4.7,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product007',
    title:
        "Logitech MK270 Wireless Keyboard and Mouse Combo - Keyboard and Mouse Included, Long Battery Life",
    price: 1103000,
    description:
        'The USB receiver is conveniently located in the box, top flap\nWork for longer with long battery life: Basic AA and AAA batteries are included with the keyboard and mouse\nKeyboard and mouse combo: The Logitech MK270 Wireless keyboard and mouse combo includes a full size keyboard and a precision mouse so you can work comfortably away from your computer\nEasy storage: The MK270 includes a plug and forget receiver that cleverly stores inside your mouse for safekeeping.\nProgrammable hotkeys to boost productivity: Automatically access frequently used applications by programming them to the 8 available hotkeys\n3-year limited hardware warranty.',
    images: [
      "https://images-na.ssl-images-amazon.com/images/I/61v%2BtaI5jvL._AC_SL1500_.jpg",
      'https://images-na.ssl-images-amazon.com/images/I/71qaS5Mt4NL._AC_SL1500_.jpg',
      'https://images-na.ssl-images-amazon.com/images/I/61tKARABuUL._AC_SL1500_.jpg',
      'https://images-na.ssl-images-amazon.com/images/I/71jWo1IbPbL._AC_SL1500_.jpg',
      'https://images-na.ssl-images-amazon.com/images/I/71iZ0zaRENL._AC_SL1500_.jpg',
      'https://images-na.ssl-images-amazon.com/images/I/81k7hqCtmML._AC_SL1500_.jpg',
      'https://images-na.ssl-images-amazon.com/images/I/71CHxt0n0UL._AC_SL1500_.jpg',
      'https://images-na.ssl-images-amazon.com/images/I/61R7hZmCd6L._AC_SL1500_.jpg',
    ],
    colors: [
      Colors.black,
    ],
    rating: 4.5,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product008',
    title:
        "iPhone Charger,5 Pack (6 FT) MBYY [Apple MFi Certified] Charger Lightning to USB Cable Compatible iPhone 12/11 Pro/11/XS MAX/XR/8/7/6s/6/plus,iPad Pro/Air/Mini,iPod Touch Original Certified-White",
    images: [
      "https://images-na.ssl-images-amazon.com/images/I/51B4dMOp49L._AC_SL1001_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/61c2ezeM1FL._AC_SL1001_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/51IZ%2BKSoh5L._AC_SL1001_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/619sbU3asyL._AC_SL1001_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/61lQOnhwTUL._AC_SL1001_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/61dS1jzgJIL._AC_SL1001_.jpg",
    ],
    colors: [
      Colors.white,
    ],
    price: 300000,
    description:
        '【Perftect Performance】 MFi Certified manufacturer brings you new experience-fast charging 2.4A and stable data transfer up to 480 mb/s,UNEN Charger Cable use authorization chip to ensure 100% compatibility with newest iOS syetem.\n【Superior Durability】lighting Cable use Superior Material,which ensure your cable 10x more durable than others,but also flexible and tangle-free.Compact aluminum connector shell head adds to extend service life getting away from the risk of crack or other kind of damage.It is durable Cable Pack who support 10000+ bending times and 10000+ repeated unplugging.\n【Fast Charging】 High-quality four-core copper wires enhance charging & data transfer speed of the iphone charging cables. Built-In MFi Certified Chipset ensures a faster charging time while keeping your device completely safe.',
    rating: 4.1,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product009',
    title: "Acer R240HY bidx 23.8-Inch IPS HDMI DVI VGA (1920 x 1080) Widescreen Monitor, Black",
    images: [
      "https://images-na.ssl-images-amazon.com/images/I/91K9SyGiyzL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/71TIMU3KATL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/71Jj0EDH21L._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/310urXyJVBL._AC_.jpg",
    ],
    colors: [
      Colors.black,
    ],
    price: 2978000,
    description:
        '23.8" Full HD IPS widescreen with 1920 x 1080 resolution\nResponse time: 4ms, refresh rate: 60 hertz, pixel pitch: 0.2745 millimeter. 178 degree wide viewing angle, display colors: 16.7 million\nThe zero frame design provides maximum visibility of the screen from edge to edge\nSignal inputs: 1 x HDMI, 1 x DVI (withHDCP) & 1 x VGA. Does not support HDCP 2.2, the version this monitor supports is HDCP 1.4\nNo picture visible using the OSD menu, adjust brightness and contrast to maximum or reset to their default settings. Brightness is 250 nit. Operating power consumption: 25 watts',
    rating: 4.3,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product010',
    title:
        "Logitech C920x HD Pro Webcam, Full HD 1080p/30fps Video Calling, Clear Stereo Audio, HD Light Correction, Works with Skype, Zoom, FaceTime, Hangouts, PC/Mac/Laptop/Macbook/Tablet - Black",
    images: [
      "https://images-na.ssl-images-amazon.com/images/I/71iNwni9TsL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/711DN05KejL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/61Eco9nudPL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/61eHA-SIfyL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/61VS-0EXcaL._AC_SL1500_.jpg",
    ],
    colors: [
      Colors.black,
    ],
    price: 2070000,
    description:
        'Full HD 1080p video calling and recording at 30 fps - You’ll make a strong impression when it counts with crisp, clearly detailed and vibrantly colored video.\nStereo audio with dual mics - Capture natural sound on calls and recorded videos.\nAdvanced capture software – Create and share video content easily with Logitech Capture.\nHD lighting adjustment and autofocus - The C920x automatically fine-tunes to the lighting conditions to produce bright, razor-sharp images even if you’re in a low-light setting.\nXSplit VCam – Remove, replace and blur your background without a Green Screen.\n3-month XSplit VCam license\n1 year limited hardware warranty',
    rating: 4.6,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product011',
    title:
        "BENGOO G9000 Stereo Gaming Headset for PS4 PC Xbox One PS5 Controller, Noise Cancelling Over Ear Headphones with Mic, LED Light, Bass Surround, Soft Memory Earmuffs for Laptop Mac Nintendo NES Games",
    images: [
      "https://images-na.ssl-images-amazon.com/images/I/61CGHv6kmWL._AC_SL1000_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/71z2WmHMtZL._AC_SL1000_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/71UAwQgt-cL._AC_SL1000_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/71Ie8vokMuL._AC_SL1000_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/71rxKLsCxqL._AC_SL1000_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/71pnikzdKkL._AC_SL1000_.jpg",
    ],
    colors: [
      Color(0xff46AEFC),
      Color(0xffA65FC4),
      Color(0xffBC181D),
    ],
    price: 943000,
    description:
        '【WIDE COMPATIBILITY】Support PlayStation 4, New Xbox One, PC, Nintendo 3DS, Laptop, PSP, Tablet, iPad, Computer, Mobile Phone. Please note you need an extra Microsoft Adapter (Not Included) when connect with an old version Xbox One controller.\n【SURROUND STEREO SUBWOOFER】Clear sound operating strong brass, splendid ambient noise isolation and high precision 40mm magnetic neodymium driver, acoustic positioning precision enhance the sensitivity of the speaker unit, bringing you vivid sound field, sound clarity, shock feeling sound. Perfect for various games like Halo 5 Guardians, Metal Gear Solid, Call of Duty, Star Wars Battlefront, Overwatch, World of Warcraft Legion, etc.\n【NOISE ISOLATION MICROPHONE】Headset integrated onmi-directional microphone can transmits high quality communication with its premium noise-concellng feature, can pick up sounds with great sensitivity and remove the noise, which enables you clearly deliver or receive messages while you are in a game. Long flexible mic design very convenient to adjust angle of the microphone.',
    rating: 4.2,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product012',
    title:
        "AMD Ryzen 5 5600X 6-core, 12-Thread Unlocked Desktop Processor with Wraith Stealth Cooler",
    images: [
      "https://images-na.ssl-images-amazon.com/images/I/61vGQNUEsGL._AC_SL1384_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/71KV0V8AxbL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/81gqOrWLmfL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/81ciJn85chL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/61hCY7E9qeL._AC_SL1395_.jpg",
    ],
    colors: [
      Colors.black,
    ],
    price: 6843000,
    description:
        'AMD\'s fastest 6 core processor for mainstream desktop, with 12 processing threads\nCan deliver elite 100+ FPS performance in the world\'s most popular games\nBundled with the quiet, capable AMD Wraith Stealth cooler\n4.6 GHz Max Boost, unlocked for overclocking, 35 MB of cache, DDR-3200 support\nFor the advanced Socket AM4 platform, can support PCIe 4.0 on X570 and B550 motherboards',
    rating: 5.0,
    ownerId: 'dungngo4520',
  ),
  Product(
    id: 'product013',
    title:
        "Samsung (MZ-V8V1T0B/AM) 980 SSD 1TB - M.2 NVMe Interface Internal Solid State Drive with V-NAND Technology",
    images: [
      "https://images-na.ssl-images-amazon.com/images/I/81YQPGH61mL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/71C-2bTBGHL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/812opUOuMzL._AC_SL1500_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/41JykwmoA2L._AC_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/51IY1y9zD9L._AC_.jpg",
    ],
    colors: [
      Colors.black,
    ],
    price: 3220000,
    description:
        'UPGRADE TO IMPRESSIVE NVMe SPEED Whether you need a boost for gaming or a seamless workflow for heavy graphics, the 980 is a smart choice for outstanding SSD performance\nPACKED WITH SPEED 980 delivers value, without sacrificing sequential read write speeds up to 3,500 3,000 MB s\nKEEP MOVING WITH FULL POWER MODE Keep your SSD running at its peak with Full Power Mode, which drives continuous and consistent high performance\nBUILT FOR THE LONG RUN With up to 600 TBW and a 5 year limited warranty, the 980\'s optimized endurance comes with trusted reliability\nRELIABLE THERMAL CONTROL 980 uses nickel coating to help manage the controller\'s heat level and a heat spreader label to deliver effective thermal control of the NAND chip.SMART THERMAL SOLUTION Embedded with Samsung\'s cutting edge thermal control algorithm, 980 manages heat on its own to deliver durable and reliable performance, while minimizing performance fluctuations during extended usage.SAMSUNG MAGICIAN SOFTWARE Monitor drive health, optimize performance, protect valuable data, and receive important updates with Magician to ensure you\'re always getting the best performance out of your SSD',
    rating: 5.0,
    ownerId: 'dungngo4520',
  ),
];
