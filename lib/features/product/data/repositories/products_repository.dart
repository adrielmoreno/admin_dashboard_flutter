import '../../domain/entities/product_response.dart';

abstract class ProductsRepository {
  Future<List<ProductResponse>> getAll();
  Future<ProductResponse?> newProduct(ProductResponse product);
  Future<void> updateProduct(ProductResponse product);
  Future<void> deleteProduct(String productId);
}
