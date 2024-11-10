import '../domain/entities/suplier_response.dart';
import 'remote/suppliers_remote_impl.dart';
import 'repositories/suppliers_repository.dart';

class SuppliersDataImpl implements SuppliersRepository {
  final SuppliersRemoteImpl _productsRemoteImpl;

  SuppliersDataImpl(this._productsRemoteImpl);

  @override
  Future<List<SupplierResponse>> getAll() {
    return _productsRemoteImpl.getAll();
  }

  @override
  Future<SupplierResponse?> newSupplier(SupplierResponse product) {
    return _productsRemoteImpl.newSupplier(product);
  }

  @override
  Future<void> updateSupplier(SupplierResponse product) {
    return _productsRemoteImpl.updateSupplier(product);
  }

  @override
  Future<void> deleteSupplier(String productId) {
    return _productsRemoteImpl.deleteSupplier(productId);
  }
}
