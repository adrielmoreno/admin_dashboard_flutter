import 'dart:developer';

import '../../../../core/data/db_services/firebase_services.dart';
import '../../domain/entities/category_response.dart';

class CategoriesRemoteImpl {
  final FirebaseServices _fireDB;

  CategoriesRemoteImpl(this._fireDB);

  Future<List<CategoryResponse>> getAll() async {
    try {
      final data = await _fireDB.categories.get();

      return data.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<CategoryResponse?> newCategory(String name) async {
    try {
      final doc = _fireDB.categories.doc();

      final category = CategoryResponse(
        id: doc.id,
        name: name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        // TODO: Change by currentUser
        creator: 'Adriel',
      );

      await doc.set(category);

      return category;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> updateCategory(CategoryResponse category) async {
    try {
      await _fireDB.categories.doc(category.id).update(category.toMap());
    } catch (e) {
      log(e.toString());
      return;
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _fireDB.categories.doc(categoryId).delete();
    } catch (e) {
      log(e.toString());
      return;
    }
  }
}
