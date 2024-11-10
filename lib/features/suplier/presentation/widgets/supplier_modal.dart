import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/di/inject.dart';
import '../../../../core/presentation/common/buttons/custom_outlined_button.dart';
import '../../../../core/presentation/common/extensions/extenssions.dart';
import '../../../../core/presentation/common/inputs/custom_inputs.dart';
import '../../../../core/presentation/common/labels/custom_labels.dart';
import '../../../../core/presentation/common/theme/constants/app_dimens.dart';
import '../../domain/entities/suplier_response.dart';
import '../view_model/suppliers_view_model.dart';

class SupplierModal extends StatefulWidget {
  const SupplierModal({super.key, this.supplier});
  final SupplierResponse? supplier;

  @override
  State<SupplierModal> createState() => _SupplierModalState();
}

class _SupplierModalState extends State<SupplierModal> {
  final _suppliersViewModel = getIt<SuppliersViewModel>();
  final TextStyle whiteTextStyle = const TextStyle(color: Colors.white);

  @override
  void initState() {
    super.initState();
    _suppliersViewModel.addListener(_onUpdate);
    _initializeFormData();
  }

  @override
  void dispose() {
    _suppliersViewModel.resetForm();
    _suppliersViewModel.removeListener(_onUpdate);
    super.dispose();
  }

  void _initializeFormData() {
    if (widget.supplier != null) {
      _loadSupplierData(widget.supplier!);
      _suppliersViewModel.isEnabled = false;
    } else {
      _suppliersViewModel.resetForm();
      _suppliersViewModel.isEnabled = true;
    }
    _onUpdate();
  }

  void _loadSupplierData(SupplierResponse supplier) {
    _suppliersViewModel.nameController.text = supplier.name;
    _suppliersViewModel.cifController.text = supplier.cif ?? '';
    _suppliersViewModel.telController.text = supplier.tel ?? '';
    _suppliersViewModel.contactNameController.text = supplier.contactName ?? '';
    _suppliersViewModel.phoneController.text = supplier.phone ?? '';
    _suppliersViewModel.type = supplier.type;
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
          widget.supplier?.name ?? 'Nuevo Proveedor',
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
      key: _suppliersViewModel.formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: _suppliersViewModel.nameController,
            hint: 'Nombre del proveedor',
            label: 'Proveedor',
            icon: Icons.business_outlined,
          ),
          const SizedBox(height: AppDimens.medium),
          _buildTextField(
            controller: _suppliersViewModel.cifController,
            hint: 'CIF',
            label: 'CIF',
            icon: Icons.perm_identity,
          ),
          const SizedBox(height: AppDimens.medium),
          _buildTextField(
            controller: _suppliersViewModel.telController,
            hint: 'Teléfono',
            label: 'Teléfono',
            icon: Icons.phone,
          ),
          const SizedBox(height: AppDimens.medium),
          _buildTextField(
            controller: _suppliersViewModel.contactNameController,
            hint: 'Nombre de contacto',
            label: 'Contacto',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: AppDimens.medium),
          _buildTextField(
            controller: _suppliersViewModel.phoneController,
            hint: 'Teléfono de contacto',
            label: 'Teléfono de Contacto',
            icon: Icons.phone_in_talk,
          ),
          const SizedBox(height: AppDimens.medium),
          _buildTypeDropdown(),
        ],
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<TypeOfSupplier>(
      dropdownColor: Colors.blue,
      isExpanded: true,
      value: _suppliersViewModel.type,
      hint: const Text(
        'Tipo de Proveedor',
        style: TextStyle(color: Colors.white),
      ),
      items: TypeOfSupplier.values.map((type) {
        return DropdownMenuItem<TypeOfSupplier>(
          value: type,
          child: Text(
            type.name,
            style: whiteTextStyle,
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _suppliersViewModel.type = value!;
        });
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
      enabled: _suppliersViewModel.isEnabled,
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
        if (_suppliersViewModel.isEnabled) {
          await _onSave();
        } else {
          _toggleEdit();
        }
      },
      text: !_suppliersViewModel.isEnabled ? 'Editar' : 'Guardar',
      color: Colors.white,
      isTextWhite: true,
    );
  }

  void _toggleEdit() {
    setState(() {
      _suppliersViewModel.isEnabled = !_suppliersViewModel.isEnabled;
    });
  }

  Future<void> _onSave() async {
    if (_suppliersViewModel.formKey.currentState!.validate()) {
      final supplier = SupplierResponse(
        id: widget.supplier?.id ?? const Uuid().v4(),
        name: _suppliersViewModel.nameController.text,
        cif: _suppliersViewModel.cifController.text,
        tel: _suppliersViewModel.telController.text,
        contactName: _suppliersViewModel.contactNameController.text,
        phone: _suppliersViewModel.phoneController.text,
        type: _suppliersViewModel.type,
      );
      try {
        await (widget.supplier != null
                ? _suppliersViewModel.updateSupplier(supplier)
                : _suppliersViewModel.newSupplier(supplier))
            .then((_) {
          context.showSnackBar('¡Proveedor guardado!');
          Navigator.of(context).pop();
        });
      } catch (e) {
        context.showSnackBarError('Error al guardar el proveedor');
      }
      if (widget.supplier == null) _suppliersViewModel.resetForm();
    }
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
