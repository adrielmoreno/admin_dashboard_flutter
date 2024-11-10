import 'package:flutter/material.dart';

import '../../domain/entities/suplier_response.dart';

class SuppliersDatasource extends DataTableSource {
  final List<SupplierResponse> suppliers;

  final void Function(SupplierResponse supplier)? onEdit;
  final void Function(SupplierResponse supplier)? onDelete;

  SuppliersDatasource({
    required this.suppliers,
    this.onEdit,
    this.onDelete,
  });

  @override
  DataRow getRow(int index) {
    final supplier = suppliers[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(supplier.name)),
        DataCell(Text(supplier.type.name)),
        DataCell(Text(supplier.cif ?? '')),
        DataCell(Text(supplier.tel ?? '')),
        DataCell(Text(supplier.contactName ?? '')),
        DataCell(Text(supplier.phone ?? '')),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () => onEdit!(supplier),
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () => onDelete!(supplier),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(supplier.id)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => suppliers.length;

  @override
  int get selectedRowCount => 0;
}
