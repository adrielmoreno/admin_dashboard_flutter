import 'dart:developer';

import '../../../../core/data/db_services/firebase_services.dart';
import '../../domain/entities/suplier_response.dart';

class SuppliersRemoteImpl {
  final FirebaseServices _fireDB;

  SuppliersRemoteImpl(this._fireDB);

  Future<List<SupplierResponse>> getAll() async {
    try {
      final data = await _fireDB.suppliers.get();

      return data.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<SupplierResponse?> newSupplier(SupplierResponse supplier) async {
    try {
      final doc = _fireDB.suppliers.doc(supplier.id);

      await doc.set(supplier);

      return supplier;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> updateSupplier(SupplierResponse supplier) async {
    try {
      await _fireDB.suppliers.doc(supplier.id).update(supplier.toMap());
    } catch (e) {
      log(e.toString());
      return;
    }
  }

  Future<void> deleteSupplier(String supplierId) async {
    try {
      await _fireDB.suppliers.doc(supplierId).delete();
    } catch (e) {
      log(e.toString());
      return;
    }
  }
}
