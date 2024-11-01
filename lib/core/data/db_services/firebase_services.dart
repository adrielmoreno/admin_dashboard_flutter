import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../features/category/domain/entities/category_response.dart';

enum FBCollection {
  CATEGORIES,
  PRODUCTS,
  USERS,
}

class FirebaseServices {
  static final _firestore = FirebaseFirestore.instance;

  FirebaseServices() {
    initializeSettings();
  }

  Future<void> initializeSettings() async {
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  String _getCollectionName(FBCollection collection) {
    String envPrefix = kDebugMode ? "debug_" : "prod_";
    String collectionName = collection.name.toLowerCase();
    return "$envPrefix$collectionName";
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

  CollectionReference<Map<String, dynamic>> get products =>
      _firestore.collection(_getCollectionName(FBCollection.PRODUCTS));

  CollectionReference<CategoryResponse> get categories =>
      getCollectionWithConverter(
        collection: FBCollection.CATEGORIES,
        fromMap: (data) => CategoryResponse.fromMap(data),
        toMap: (category) => category.toMap(),
      );

  CollectionReference<Map<String, dynamic>> get users =>
      _firestore.collection(_getCollectionName(FBCollection.USERS));

  Future<DocumentReference> getReference(
      String documentId, FBCollection collection) async {
    return _firestore
        .collection(_getCollectionName(collection))
        .doc(documentId);
  }
}
