import '../domain/entities/product_response.dart';
import 'remote/products_remote_impl.dart';
import 'repositories/products_repository.dart';

class ProductsDataImpl implements ProductsRepository {
  final ProductsRemoteImpl _productsRemoteImpl;

  ProductsDataImpl(this._productsRemoteImpl);

  @override
  Future<List<ProductResponse>> getAll() {
    return _productsRemoteImpl.getAll();
  }

  @override
  Future<ProductResponse?> newProduct(ProductResponse product) {
    return _productsRemoteImpl.newProduct(product);
  }

  @override
  Future<void> updateProduct(ProductResponse product) {
    return _productsRemoteImpl.updateProduct(product);
  }

  @override
  Future<void> deleteProduct(String productId) {
    return _productsRemoteImpl.deleteProduct(productId);
  }
}
