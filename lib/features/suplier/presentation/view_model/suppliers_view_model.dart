import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../data/repositories/suppliers_repository.dart';
import '../../domain/entities/suplier_response.dart';

class SuppliersViewModel extends ChangeNotifier {
  final SuppliersRepository _suppliersRepository;
  SuppliersViewModel(this._suppliersRepository);

  List<SupplierResponse> suppliers = [];

  Future<void> getSuppliers() async {
    suppliers = await _suppliersRepository.getAll();
    notifyListeners();
  }

  Future<void> newSupplier(SupplierResponse supplier) async {
    final newsupplier = await _suppliersRepository.newSupplier(supplier);

    if (newsupplier != null) {
      _addNewSupplier(newsupplier);
    }
  }

  Future<void> updateSupplier(SupplierResponse supplier) async {
    await _suppliersRepository.updateSupplier(supplier);

    final index = suppliers.indexWhere((value) => value.id == supplier.id);

    suppliers[index] = supplier;
    notifyListeners();
  }

  Future<void> deleteSupplier(String supplierId) async {
    await _suppliersRepository.deleteSupplier(supplierId);

    suppliers.removeWhere((value) => value.id == supplierId);
    notifyListeners();
  }

  void _addNewSupplier(SupplierResponse supplier) {
    suppliers.add(supplier);
    notifyListeners();
  }

  // Supplier Form
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cifController = TextEditingController();
  final _telController = TextEditingController();
  PhoneNumber localPhone = PhoneNumber(isoCode: 'ES');
  final _contactNameController = TextEditingController();
  final _phoneController = TextEditingController();
  PhoneNumber contactPhone = PhoneNumber(isoCode: 'ES');

  TypeOfSupplier _type = TypeOfSupplier.food;

  bool _isEnabled = true;

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get nameController => _nameController;
  TextEditingController get cifController => _cifController;
  TextEditingController get telController => _telController;
  TextEditingController get contactNameController => _contactNameController;
  TextEditingController get phoneController => _phoneController;
  TypeOfSupplier get type => _type;
  bool get isEnabled => _isEnabled;

  set type(TypeOfSupplier value) {
    _type = value;
    notifyListeners();
  }

  set isEnabled(bool value) {
    _isEnabled = value;
    notifyListeners();
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _cifController.clear();
    _telController.clear();
    localPhone = PhoneNumber(isoCode: 'ES');
    _contactNameController.clear();
    _phoneController.clear();
    contactPhone = PhoneNumber(isoCode: 'ES');
    _type = TypeOfSupplier.food;
    notifyListeners();
  }
  // ---- End form -----
}
