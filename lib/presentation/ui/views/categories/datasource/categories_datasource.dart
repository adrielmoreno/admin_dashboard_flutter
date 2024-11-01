import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../domain/entities/category_response.dart';
import '../../../../../external/di/inject.dart';
import '../../../../common/modals/category_modal.dart';
import '../view_model/categories_view_model.dart';

class CategoriesDatasource extends DataTableSource {
  final List<CategoryResponse> _categories;
  final BuildContext _context;
  CategoriesDatasource(this._categories, this._context);

  @override
  DataRow getRow(int index) {
    final category = _categories[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(category.name)),
        DataCell(Text(category.creator)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // TODO: Will ad scroll
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: _context,
                    builder: (_) => CategoryModal(
                      category: category,
                    ),
                  );
                },
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () {
                  final dialog = AlertDialog(
                    title: const Text('¿Está seguro de borrarlo?'),
                    content: Text('¿Borrar definitivamente ${category.name}?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            _context.pop();
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () async {
                            getIt<CategoriesViewModel>()
                                .deleteCategory(category.id);

                            _context.pop();
                          },
                          child: const Text('Si, borrar')),
                    ],
                  );

                  showDialog(
                    context: _context,
                    builder: (context) => dialog,
                  );
                },
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
  int get rowCount => _categories.length;

  @override
  int get selectedRowCount => 0;
}
