import 'package:algolia/algolia.dart';
import 'package:ecommerce/models/Product.dart';

class AlgoliaSearch {
  static final Algolia algolia = Algolia.init(
      applicationId: "9RKZ93TV3X", apiKey: "1f2396c20f086c62cf935e26e7021dfe");

  Future<List<Product>> searchProduct(String name) async {
    AlgoliaQuery query = algolia.instance.index('products').query(name);
    AlgoliaQuerySnapshot querySnapshot = await query.getObjects();
    return querySnapshot.hits.map((e) => Product.fromMap(e.data)).toList();
  }

  Future sendData(Map<String, dynamic> map) async {
    await algolia.instance.index('products').addObject(map);
  }
}
