import 'package:flutter/material.dart';

import '../../common/cards/white_card.dart';
import '../../common/labels/custom_labels.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Dashboard View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          const WhiteCard(title: 'Sales Statistics', child: Text('Hola Mundo'))
        ],
      ),
    );
  }
}
