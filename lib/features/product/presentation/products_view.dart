import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/di/inject.dart';
import '../../../core/presentation/common/buttons/custom_icon_button.dart';
import '../../../core/presentation/common/labels/custom_labels.dart';
import '../../../core/presentation/common/theme/constants/app_dimens.dart';
import 'datasource/products_datasource.dart';
import 'view_model/products_view_model.dart';
import 'widgets/product_modal.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});
  static const String route = 'products';

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  int? _rowsPerPgee = PaginatedDataTable.defaultRowsPerPage;
  final _productsVewModel = getIt<ProductsViewModel>();
  @override
  void initState() {
    super.initState();
    _productsVewModel.addListener(_onUpdate);
    _productsVewModel.getProducts();
  }

  @override
  void dispose() {
    _productsVewModel.addListener(_onUpdate);
    super.dispose();
  }

  void _onUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (_productsVewModel.products.isEmpty) {
    //   return const Center(
    //     child: CircularProgressIndicator(
    //       color: Colors.blue,
    //     ),
    //   );
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.semiBig, vertical: AppDimens.semiMedium),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            'Productos',
            style: CustomLabels.h1,
          ),
          const SizedBox(height: AppDimens.semiMedium),
          PaginatedDataTable(
            header: const Text(
              "Productos disponibles",
              maxLines: 2,
            ),
            actions: [
              CustomIconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => const ProductModal(),
                  );
                },
                text: 'Nuevo',
                icon: Icons.add_outlined,
              )
            ],
            columns: const [
              DataColumn(label: Text('Nombe')),
              DataColumn(label: Text('Empaque')),
              DataColumn(label: Text('Medida')),
              DataColumn(label: Text('Precio Empaque')),
              DataColumn(label: Text('Precio Unidad')),
              DataColumn(label: Text('IVA')),
              DataColumn(label: Text('Precio/U+IVA')),
              DataColumn(label: Text('Suplidor')),
              DataColumn(label: Text('Acciones')),
              DataColumn(label: Text('ID')),
            ],
            source: ProductsDatasource(
              products: _productsVewModel.products,
              // EDIT
              onEdit: (product) {
                {
                  // TODO: Will ad scroll
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => ProductModal(
                      product: product,
                    ),
                  );
                }
              },
              // DELETE
              onDelete: (product) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('¿Está seguro de borrarlo?'),
                    content: Text('¿Borrar definitivamente ${product.name}?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () async {
                            getIt<ProductsViewModel>()
                                .deleteProduct(product.id);

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
            rowsPerPage: _rowsPerPgee ?? 0,
          )
        ],
      ),
    );
  }
}
