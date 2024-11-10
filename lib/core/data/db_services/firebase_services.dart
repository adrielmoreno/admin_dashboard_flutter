import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../features/category/domain/entities/category_response.dart';
import '../../../features/product/domain/entities/product_response.dart';
import '../../../features/suplier/domain/entities/suplier_response.dart';

enum FBCollection {
  categories,
  products,
  suppliers,
  users,
}

class FirebaseServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _debugPrefix = "debug_";
  static const String _prodPrefix = "prod_";

  FirebaseServices() {
    _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  String _getCollectionName(FBCollection collection) {
    const envPrefix = kDebugMode ? _debugPrefix : _prodPrefix;
    return "$envPrefix${collection.name}";
  }

  CollectionReference<T> getCollectionWithConverter<T>({
    required FBCollection collection,
    required T Function(Map<String, dynamic>) fromMap,
    required Map<String, dynamic> Function(T) toMap,
  }) {
    return _firestore
        .collection(_getCollectionName(collection))
        .withConverter<T>(
          fromFirestore: (snapshot, _) => snapshot.data() != null
              ? fromMap(snapshot.data()!)
              : throw Exception("No data found"),
          toFirestore: (item, _) => toMap(item),
        );
  }

  CollectionReference<ProductResponse> get products =>
      getCollectionWithConverter(
        collection: FBCollection.products,
        fromMap: (data) => ProductResponse.fromMap(data),
        toMap: (product) => product.toMap(),
      );

  CollectionReference<CategoryResponse> get categories =>
      getCollectionWithConverter(
        collection: FBCollection.categories,
        fromMap: (data) => CategoryResponse.fromMap(data),
        toMap: (category) => category.toMap(),
      );

  CollectionReference<SupplierResponse> get suppliers =>
      getCollectionWithConverter(
        collection: FBCollection.suppliers,
        fromMap: (data) => SupplierResponse.fromMap(data),
        toMap: (supplier) => supplier.toMap(),
      );

  CollectionReference<Map<String, dynamic>> get users =>
      _firestore.collection(_getCollectionName(FBCollection.users));
}
