import '../../domain/entities/category_response.dart';

abstract class CategoriesRepository {
  Future<List<CategoryResponse>> getAll();
  Future<CategoryResponse?> newCategory(String name);
  Future<void> updateCategory(CategoryResponse category);
  Future<void> deleteCategory(String categoryId);
}
