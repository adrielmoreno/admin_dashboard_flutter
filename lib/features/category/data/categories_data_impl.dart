import '../domain/entities/category_response.dart';
import 'remote/categories_remote_impl.dart';
import 'repositories/categories_repository.dart';

class CategoriesDataImpl implements CategoriesRepository {
  final CategoriesRemoteImpl _categoriesRemoteImpl;

  CategoriesDataImpl(this._categoriesRemoteImpl);

  @override
  Future<List<CategoryResponse>> getAll() {
    return _categoriesRemoteImpl.getAll();
  }

  @override
  Future<CategoryResponse?> newCategory(String name) {
    return _categoriesRemoteImpl.newCategory(name);
  }

  @override
  Future<void> updateCategory(CategoryResponse category) {
    return _categoriesRemoteImpl.updateCategory(category);
  }

  @override
  Future<void> deleteCategory(String categoryId) {
    return _categoriesRemoteImpl.deleteCategory(categoryId);
  }
}
