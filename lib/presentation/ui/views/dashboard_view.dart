import 'package:flutter/material.dart';

import '../../common/cards/white_card.dart';
import '../../common/labels/custom_labels.dart';
import '../../common/theme/constants/app_dimens.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  static const String route = 'dashboard';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.semiBig, vertical: AppDimens.semiMedium),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Dashboard View', style: CustomLabels.h1),
          const SizedBox(height: AppDimens.semiMedium),
          const WhiteCard(title: 'Sales Statistics', child: Text('Hola Mundo'))
        ],
      ),
    );
  }
}
