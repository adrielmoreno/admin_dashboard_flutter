import 'package:flutter/material.dart';

import '../../../../common/inputs/custom_inputs.dart';
import '../../../../common/theme/constants/app_dimens.dart';

class SearchText extends StatelessWidget {
  const SearchText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.semiHuge,
      decoration: buildBoxDecoration(),
      child: TextField(
        decoration: CustomInputs.searchInputDecoration(
            hint: 'Buscar', icon: Icons.search_outlined),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.circular(AppDimens.semiMedium),
      color: Colors.grey.withOpacity(0.1));
}
