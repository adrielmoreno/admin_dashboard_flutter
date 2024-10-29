import 'package:flutter/material.dart';

import '../../../../external/di/inject.dart';
import '../../../common/buttons/custom_icon_button.dart';
import '../../../common/labels/custom_labels.dart';
import '../../../common/modals/category_modal.dart';
import '../../../common/theme/constants/app_dimens.dart';
import 'datasource/categories_datasource.dart';
import 'view_model/categories_view_model.dart';

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
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Categoría')),
              DataColumn(label: Text('Autor')),
              DataColumn(label: Text('Acciones')),
            ],
            source:
                CategoriesDatasource(_categoriesVewModel.categories, context),
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
