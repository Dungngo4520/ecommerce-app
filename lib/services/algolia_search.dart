import 'package:algolia/algolia.dart';
import 'package:ecommerce/models/Product.dart';

class AlgoliaSearch {
  static final Algolia algolia =
      Algolia.init(applicationId: "APP_ID", apiKey: "ADMIN_ID");

  Future<List<Product>> searchProduct(String name) async {
    AlgoliaQuery query = algolia.instance.index('products').query(name);
    AlgoliaQuerySnapshot querySnapshot = await query.getObjects();
    return querySnapshot.hits.map((e) => Product.fromMap(e.data)).toList();
  }

  Future sendData(Map<String, dynamic> map) async {
    await algolia.instance.index('products').addObject(map);
  }
}
