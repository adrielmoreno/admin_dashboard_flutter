import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/di/inject.dart';
import '../../../core/presentation/common/buttons/custom_icon_button.dart';
import '../../../core/presentation/common/labels/custom_labels.dart';
import '../../../core/presentation/common/theme/constants/app_dimens.dart';
import 'datasource/suppliers_datasource.dart';
import 'view_model/suppliers_view_model.dart';
import 'widgets/supplier_modal.dart';

class SuppliersView extends StatefulWidget {
  const SuppliersView({super.key});
  static const String route = 'suppliers';

  @override
  State<SuppliersView> createState() => _SuppliersViewState();
}

class _SuppliersViewState extends State<SuppliersView> {
  int? _rowsPerPgee = PaginatedDataTable.defaultRowsPerPage;
  final _suppliersVewModel = getIt<SuppliersViewModel>();
  @override
  void initState() {
    super.initState();
    _suppliersVewModel.addListener(_onUpdate);
    _suppliersVewModel.getSuppliers();
  }

  @override
  void dispose() {
    _suppliersVewModel.addListener(_onUpdate);
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
    // if (_suppliersVewModel.suppliers.isEmpty) {
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
            'Supplieros',
            style: CustomLabels.h1,
          ),
          const SizedBox(height: AppDimens.semiMedium),
          PaginatedDataTable(
            header: const Text(
              "Supplieros disponibles",
              maxLines: 2,
            ),
            actions: [
              CustomIconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => const SupplierModal(),
                  );
                },
                text: 'Nuevo',
                icon: Icons.add_outlined,
              )
            ],
            columns: const [
              DataColumn(label: Text('Nombe')),
              DataColumn(label: Text('Tipo')),
              DataColumn(label: Text('CIF')),
              DataColumn(label: Text('TEL')),
              DataColumn(label: Text('Contacto')),
              DataColumn(label: Text('Móvil')),
              DataColumn(label: Text('Acciones')),
              DataColumn(label: Text('ID')),
            ],
            source: SuppliersDatasource(
              suppliers: _suppliersVewModel.suppliers,
              // EDIT
              onEdit: (supplier) {
                {
                  // TODO: Will ad scroll
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => SupplierModal(
                      supplier: supplier,
                    ),
                  );
                }
              },
              // DELETE
              onDelete: (supplier) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('¿Está seguro de borrarlo?'),
                    content: Text('¿Borrar definitivamente ${supplier.name}?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () async {
                            getIt<SuppliersViewModel>()
                                .deleteSupplier(supplier.id);

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
