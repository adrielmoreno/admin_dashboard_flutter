import 'package:flutter/material.dart';

import '../../../suplier/domain/entities/suplier_response.dart';
import '../../data/repositories/products_repository.dart';
import '../../domain/entities/product_response.dart';

class ProductsViewModel extends ChangeNotifier {
  final ProductsRepository _productsRepository;
  ProductsViewModel(this._productsRepository);

  List<ProductResponse> products = [];

  Future<void> getProducts() async {
    products = await _productsRepository.getAll();
    notifyListeners();
  }

  Future<void> newProduct(ProductResponse product) async {
    final newproduct = await _productsRepository.newProduct(product);

    if (newproduct != null) {
      _addNewProduct(newproduct);
    }
  }

  Future<void> updateProduct(ProductResponse product) async {
    await _productsRepository.updateProduct(product);

    final index = products.indexWhere((value) => value.id == product.id);

    products[index] = product;
    notifyListeners();
  }

  Future<void> deleteProduct(String productId) async {
    await _productsRepository.deleteProduct(productId);

    products.removeWhere((value) => value.id == productId);
    notifyListeners();
  }

  void _addNewProduct(ProductResponse product) {
    products.add(product);
    notifyListeners();
  }

  // Product Form
  // ------ form -------
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _packagingController = TextEditingController();
  final _measureController = TextEditingController();
  final _pricePackingController = TextEditingController();
  final _priceUnitController = TextEditingController();
  final _ivaController = TextEditingController();
  final _pricePlusIVA = TextEditingController();
  SupplierResponse? _lastSupplier;
  double _iva = 0.0;
  bool _isEnabled = true;

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get nameController => _nameController;
  TextEditingController get packagingController => _packagingController;
  TextEditingController get measureController => _measureController;
  TextEditingController get pricePackingController => _pricePackingController;
  TextEditingController get priceUnitController => _priceUnitController;
  TextEditingController get ivaController => _ivaController;
  TextEditingController get pricePlusIVA => _pricePlusIVA;
  SupplierResponse? get lastSupplier => _lastSupplier;
  double get iva => _iva;
  bool get isEnabled => _isEnabled;

  set isEnabled(bool value) {
    _isEnabled = value;
    notifyListeners();
  }

  set lastSupplier(SupplierResponse? value) {
    _lastSupplier = value;
    notifyListeners();
  }

  set iva(double value) {
    _iva = value;
    notifyListeners();
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _packagingController.clear();
    _measureController.clear();
    _pricePackingController.clear();
    _priceUnitController.clear();
    _pricePlusIVA.clear();
    _iva = 0.0;
    _ivaController.clear();
    _lastSupplier = null;
    notifyListeners();
  }
}
