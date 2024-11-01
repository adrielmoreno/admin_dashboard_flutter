import 'package:flutter/material.dart';

import '../../domain/entities/category_response.dart';

class CategoriesDatasource extends DataTableSource {
  final List<CategoryResponse> categories;

  final void Function(CategoryResponse category)? onEdit;
  final void Function(CategoryResponse category)? onDelete;

  CategoriesDatasource({
    required this.categories,
    this.onEdit,
    this.onDelete,
  });

  @override
  DataRow getRow(int index) {
    final category = categories[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(category.name)),
        DataCell(Text(category.creator)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () => onEdit!(category),
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () => onDelete!(category),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(category.id)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => 0;
}
