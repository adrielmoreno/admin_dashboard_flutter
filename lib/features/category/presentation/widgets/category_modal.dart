import 'package:flutter/material.dart';

import '../../../../app/di/inject.dart';
import '../../../../core/presentation/common/buttons/custom_outlined_button.dart';
import '../../../../core/presentation/common/extensions/extenssions.dart';
import '../../../../core/presentation/common/inputs/custom_inputs.dart';
import '../../../../core/presentation/common/labels/custom_labels.dart';
import '../../../../core/presentation/common/theme/constants/app_dimens.dart';
import '../../domain/entities/category_response.dart';
import '../view_model/categories_view_model.dart';

class CategoryModal extends StatefulWidget {
  const CategoryModal({super.key, this.category});
  final CategoryResponse? category;

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  final _categoryViewModel = getIt<CategoriesViewModel>();
  String? name;
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.category?.id;
    name = widget.category?.name;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: true,
        builder: (context, controller) {
          return Container(
            padding: const EdgeInsets.all(AppDimens.semiBig),
            decoration: buidBoxDecoration(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: controller,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.category?.name ?? 'Nueva categoría',
                        style: CustomLabels.h1.copyWith(color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close_outlined,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Divider(color: Colors.white.withOpacity(0.3)),
                  const SizedBox(height: AppDimens.medium),

                  // Inputs
                  TextFormField(
                    initialValue: widget.category?.name,
                    onChanged: (value) => name = value,
                    decoration: CustomInputs.loginInputDecoration(
                      hint: 'Nombre de la categoría',
                      label: 'Categoría',
                      icon: Icons.new_label_outlined,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),

                  // Button
                  Container(
                    margin: const EdgeInsets.only(top: AppDimens.semiBig),
                    alignment: Alignment.center,
                    child: CustomOutlinedButton(
                      onPressed: () {
                        if (id == null && name != null) {
                          _categoryViewModel.newCategory(name!);
                          context.showSnackBar('!$name cread@');
                        } else if (widget.category != null) {
                          final category = widget.category
                              ?.copyWith(name: name, updatedAt: DateTime.now());

                          _categoryViewModel.updateCategory(category!);
                          context.showSnackBarError('!$name actualizad@');
                        }
                        Navigator.of(context).pop();
                      },
                      text: id != null ? 'Editar' : 'Guardar',
                      color: Colors.white,
                      isTextWhite: true,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  BoxDecoration buidBoxDecoration() {
    return const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimens.semiBig),
            topRight: Radius.circular(AppDimens.semiBig)),
        color: Color(0xff0f2041),
        boxShadow: [BoxShadow(color: Colors.black26)]);
  }
}
