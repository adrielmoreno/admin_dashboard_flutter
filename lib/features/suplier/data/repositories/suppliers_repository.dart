import '../../domain/entities/suplier_response.dart';

abstract class SuppliersRepository {
  Future<List<SupplierResponse>> getAll();
  Future<SupplierResponse?> newSupplier(SupplierResponse supplier);
  Future<void> updateSupplier(SupplierResponse supplier);
  Future<void> deleteSupplier(String supplierId);
}
