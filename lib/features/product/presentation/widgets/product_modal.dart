import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/di/inject.dart';
import '../../../../core/data/db_services/firebase_services.dart';
import '../../../../core/presentation/common/buttons/custom_outlined_button.dart';
import '../../../../core/presentation/common/extensions/extenssions.dart';
import '../../../../core/presentation/common/inputs/custom_inputs.dart';
import '../../../../core/presentation/common/labels/custom_labels.dart';
import '../../../../core/presentation/common/theme/constants/app_dimens.dart';
import '../../../suplier/domain/entities/suplier_response.dart';
import '../../domain/entities/product_response.dart';
import '../view_model/products_view_model.dart';

class ProductModal extends StatefulWidget {
  const ProductModal({super.key, this.product});
  final ProductResponse? product;

  @override
  State<ProductModal> createState() => _ProductModalState();
}

class _ProductModalState extends State<ProductModal> {
  final _productViewModel = getIt<ProductsViewModel>();
  final TextStyle whiteTextStyle = const TextStyle(color: Colors.white);

  @override
  void initState() {
    super.initState();
    _productViewModel.addListener(_onUpdate);
    _initializeFormData();
  }

  @override
  void dispose() {
    _productViewModel.resetForm();
    _productViewModel.removeListener(_onUpdate);
    super.dispose();
  }

  void _initializeFormData() async {
    if (widget.product != null) {
      _loadProductData(widget.product!);
      _productViewModel.isEnabled = false;
    } else {
      _productViewModel.resetForm();
      _productViewModel.isEnabled = true;
    }
    _onUpdate();
  }

  void _loadProductData(ProductResponse product) async {
    _productViewModel.nameController.text = product.name;
    _productViewModel.packagingController.text = product.packaging.toString();
    _productViewModel.measureController.text = product.measure;
    _productViewModel.pricePackingController.text =
        product.pricePacking.toString();
    _productViewModel.priceUnitController.text = product.priceUnit.toString();
    _productViewModel.ivaController.text = product.iva.toString();
    _productViewModel.pricePlusIVA.text = product.pricePlusIVA.toString();
    _productViewModel.lastSupplier = product.lastSupplier != null
        ? (await product.lastSupplier?.get())?.data()
        : null;
  }

  void _onUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(AppDimens.semiBig),
          decoration: _buildBoxDecoration(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: controller,
            child: Column(
              children: [
                _buildHeader(context),
                const Divider(),
                const SizedBox(height: AppDimens.medium),
                _buildForm(),
                const SizedBox(height: AppDimens.semiBig),
                _buildActionButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.product?.name ?? 'Nuevo Producto',
          style: CustomLabels.h1.copyWith(color: Colors.white),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_outlined, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _productViewModel.formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: _productViewModel.nameController,
            hint: 'Nombre del producto',
            label: 'Producto',
            icon: Icons.new_label_outlined,
          ),
          const SizedBox(height: AppDimens.medium),
          _buildPackagingRow(),
          const SizedBox(height: AppDimens.medium),
          _buildPriceRow(),
          const SizedBox(height: AppDimens.medium),
          _buildIVAandPricePlusIVARow(),
          const SizedBox(height: AppDimens.medium),
          _buildSupplierDropdown(),
        ],
      ),
    );
  }

  Widget _buildPackagingRow() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: _productViewModel.packagingController,
            label: 'Empaquetado',
            keyboardType: TextInputType.number,
            onChanged: (_) => _updatePrices(),
          ),
        ),
        const SizedBox(width: AppDimens.medium),
        Expanded(
          child: _buildTextField(
            controller: _productViewModel.measureController,
            label: 'Medida',
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: _productViewModel.pricePackingController,
            label: 'Precio Empaque',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => _updatePrices(),
          ),
        ),
        const SizedBox(width: AppDimens.medium),
        Expanded(
          child: _buildTextField(
            controller: _productViewModel.priceUnitController,
            label: 'Precio Unitario',
            readOnly: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }

  Widget _buildIVAandPricePlusIVARow() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: _productViewModel.ivaController,
            label: 'IVA',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => _updatePrices(),
          ),
        ),
        const SizedBox(width: AppDimens.medium),
        Expanded(
          child: _buildTextField(
            controller: _productViewModel.pricePlusIVA,
            label: 'Precio + IVA',
            readOnly: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }

  Widget _buildSupplierDropdown() {
    return FutureBuilder(
      future: getIt<FirebaseServices>().suppliers.get(),
      builder: (context, snap) {
        final suppliers = snap.data?.docs.map((doc) => doc.data()).toList();
        return DropdownButtonFormField<SupplierResponse>(
          dropdownColor: Colors.blue,
          isExpanded: true,
          value: _productViewModel.lastSupplier,
          hint: const Text(
            'Último proveedor',
            style: TextStyle(color: Colors.white),
          ),
          items: suppliers?.map((supplier) {
            return DropdownMenuItem<SupplierResponse>(
              enabled: _productViewModel.isEnabled,
              value: supplier,
              child: Text(
                supplier.name,
                style: whiteTextStyle,
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _productViewModel.lastSupplier = value;
            });
          },
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hint,
    String? label,
    IconData? icon,
    bool readOnly = false,
    TextInputType? keyboardType,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      enabled: _productViewModel.isEnabled,
      readOnly: readOnly,
      decoration: CustomInputs.loginInputDecoration(
        hint: hint ?? '',
        label: label ?? '',
        icon: icon,
      ),
      style: whiteTextStyle,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: (value) =>
          value == null || value.isEmpty ? 'No puede estar vacío' : null,
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: () async {
        if (_productViewModel.isEnabled) {
          await _onSave();
        } else {
          _toggleEdit();
        }
      },
      text: !_productViewModel.isEnabled ? 'Editar' : 'Guardar',
      color: Colors.white,
      isTextWhite: true,
    );
  }

  void _toggleEdit() {
    setState(() {
      _productViewModel.isEnabled = !_productViewModel.isEnabled;
    });
  }

  Future<void> _onSave() async {
    if (_productViewModel.formKey.currentState!.validate()) {
      final product = ProductResponse(
        id: widget.product?.id ?? const Uuid().v4(),
        name: _productViewModel.nameController.text,
        packaging: _parseInput(_productViewModel.packagingController.text),
        measure: _productViewModel.measureController.text,
        pricePacking:
            _parseInput(_productViewModel.pricePackingController.text),
        priceUnit: _calculateUnitPrice(),
        iva: _productViewModel.iva,
        pricePlusIVA: _calculatePricePlusIVA(),
        lastSupplier: _productViewModel.lastSupplier != null
            ? getIt<FirebaseServices>()
                .suppliers
                .doc(_productViewModel.lastSupplier!.id)
            : null,
        createdAt: widget.product?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );
      try {
        await (widget.product != null
                ? _productViewModel.updateProduct(product)
                : _productViewModel.newProduct(product))
            .then((_) {
          context.showSnackBar('¡Producto guardado!');
          Navigator.of(context).pop();
        });
      } catch (e) {
        context.showSnackBarError('Error al guardar el producto');
      }
      if (widget.product == null) _productViewModel.resetForm();
    }
  }

  void _updatePrices() {
    setState(() {
      _productViewModel.iva = _parseInput(_productViewModel.ivaController.text);
      _calculateUnitPrice();
      _calculatePricePlusIVA();
    });
  }

  double _parseInput(String value) =>
      double.tryParse(value.replaceAll(',', '.')) ?? 0.0;

  double _calculateUnitPrice() {
    final pricePacking =
        _parseInput(_productViewModel.pricePackingController.text);
    final packaging = _parseInput(_productViewModel.packagingController.text);

    if (packaging != 0) {
      final unitPrice = pricePacking / packaging;
      _productViewModel.priceUnitController.text = unitPrice.toStringAsFixed(2);
      return unitPrice;
    } else {
      _productViewModel.priceUnitController.clear();
      return 0.0;
    }
  }

  double _calculatePricePlusIVA() {
    final unitPrice = _parseInput(_productViewModel.priceUnitController.text);
    final iva = _productViewModel.iva;

    final taxes = unitPrice * iva / 100;
    final totalWithIVA = unitPrice + taxes;

    _productViewModel.pricePlusIVA.text = totalWithIVA.toStringAsFixed(2);
    return totalWithIVA;
  }

  BoxDecoration _buildBoxDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppDimens.semiBig),
        topRight: Radius.circular(AppDimens.semiBig),
      ),
      color: Color(0xff0f2041),
      boxShadow: [BoxShadow(color: Colors.black26)],
    );
  }
}
