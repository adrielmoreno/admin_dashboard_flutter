import 'package:flutter/material.dart';

import '../../domain/entities/product_response.dart';

class ProductsDatasource extends DataTableSource {
  final List<ProductResponse> products;

  final void Function(ProductResponse product)? onEdit;
  final void Function(ProductResponse product)? onDelete;

  ProductsDatasource({
    required this.products,
    this.onEdit,
    this.onDelete,
  });

  @override
  DataRow getRow(int index) {
    final product = products[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(product.name)),
        DataCell(Text('${product.packaging}')),
        DataCell(Text(product.measure)),
        DataCell(Text('${product.pricePacking}')),
        DataCell(Text(product.priceUnit.toStringAsFixed(2))),
        DataCell(Text('${product.iva}')),
        DataCell(Text(product.pricePlusIVA.toStringAsFixed(2))),
        DataCell(
          StreamBuilder(
            stream: product.lastSupplier?.snapshots(),
            builder: (context, snap) {
              return Text(snap.data?.data()?.name ?? '');
            },
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () => onEdit!(product),
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () => onDelete!(product),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(product.id)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
}
