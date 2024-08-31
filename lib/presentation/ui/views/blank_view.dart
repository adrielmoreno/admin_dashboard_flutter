import 'package:flutter/material.dart';

import '../../common/cards/white_card.dart';
import '../../common/labels/custom_labels.dart';
import '../../common/theme/constants/app_dimens.dart';

class BlankView extends StatelessWidget {
  const BlankView({super.key});
  static const String route = 'blank';

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text('Blank View', style: CustomLabels.h1),
        const SizedBox(height: AppDimens.semiMedium),
        const WhiteCard(title: 'Blank View', child: Text('Hola Mundo'))
      ],
    );
  }
}
