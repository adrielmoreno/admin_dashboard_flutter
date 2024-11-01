import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/di/inject.dart';
import '../../../core/presentation/common/buttons/custom_icon_button.dart';
import '../../../core/presentation/common/labels/custom_labels.dart';
import '../../../core/presentation/common/theme/constants/app_dimens.dart';
import 'datasource/categories_datasource.dart';
import 'view_model/categories_view_model.dart';
import 'widgets/category_modal.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});
  static const String route = 'categories';

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int? _rowsPerPgee = PaginatedDataTable.defaultRowsPerPage;
  final _categoriesVewModel = getIt<CategoriesViewModel>();
  @override
  void initState() {
    super.initState();
    _categoriesVewModel.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _categoriesVewModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    if (_categoriesVewModel.categories.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.semiBig, vertical: AppDimens.semiMedium),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            'Categories View',
            style: CustomLabels.h1,
          ),
          const SizedBox(height: AppDimens.semiMedium),
          PaginatedDataTable(
            header: const Text(
              "Categorías disponibles",
              maxLines: 2,
            ),
            actions: [
              CustomIconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => const CategoryModal(),
                  );
                },
                text: 'Nuevo',
                icon: Icons.add_outlined,
              )
            ],
            columns: const [
              DataColumn(label: Text('Categoría')),
              DataColumn(label: Text('Autor')),
              DataColumn(label: Text('Acciones')),
              DataColumn(label: Text('ID')),
            ],
            source: CategoriesDatasource(
              categories: _categoriesVewModel.categories,
              // EDIT
              onEdit: (category) {
                {
                  // TODO: Will ad scroll
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => CategoryModal(
                      category: category,
                    ),
                  );
                }
              },
              // DELETE
              onDelete: (category) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('¿Está seguro de borrarlo?'),
                    content: Text('¿Borrar definitivamente ${category.name}?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () async {
                            getIt<CategoriesViewModel>()
                                .deleteCategory(category.id);

                            context.pop();
                          },
                          child: const Text('Si, borrar')),
                    ],
                  ),
                );
              },
            ),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPgee = value;
              });
            },
            rowsPerPage: _rowsPerPgee!,
          )
        ],
      ),
    );
  }
}
