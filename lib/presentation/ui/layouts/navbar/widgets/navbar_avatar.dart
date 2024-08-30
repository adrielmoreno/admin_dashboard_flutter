import 'package:flutter/material.dart';

import '../../../../common/theme/constants/app_dimens.dart';

class NavbarAvatar extends StatelessWidget {
  const NavbarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: AppDimens.big,
        height: AppDimens.big,
        child: Image.network(
            'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
      ),
    );
  }
}
