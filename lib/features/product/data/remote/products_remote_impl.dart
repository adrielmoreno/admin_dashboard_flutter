import 'dart:developer';

import '../../../../core/data/db_services/firebase_services.dart';
import '../../domain/entities/product_response.dart';

class ProductsRemoteImpl {
  final FirebaseServices _fireDB;

  ProductsRemoteImpl(this._fireDB);

  Future<List<ProductResponse>> getAll() async {
    try {
      final data = await _fireDB.products.get();

      return data.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<ProductResponse?> newProduct(ProductResponse product) async {
    try {
      final doc = _fireDB.products.doc(product.id);

      await doc.set(product);

      return product;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> updateProduct(ProductResponse product) async {
    try {
      await _fireDB.products.doc(product.id).update(product.toMap());
    } catch (e) {
      log(e.toString());
      return;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _fireDB.products.doc(productId).delete();
    } catch (e) {
      log(e.toString());
      return;
    }
  }
}
