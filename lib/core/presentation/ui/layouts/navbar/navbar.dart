import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../common/theme/constants/app_dimens.dart';
import '../sidebar/providers/sidemenu_provider.dart';
import 'widgets/navbar_avatar.dart';
import 'widgets/notifications_indicator.dart';
import 'widgets/search_text.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);

    return Container(
      width: double.infinity,
      height: AppDimens.huge,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          if (breakpoint.smallerThan(TABLET))
            const IconButton(
              icon: Icon(Icons.menu_outlined),
              onPressed: SideMenuProvider.openMenu,
            ),

          const SizedBox(width: AppDimens.extraSmall),

          // Search input
          if (breakpoint.screenWidth > 390)
            ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AppDimens.maxInputWidth),
              child: const SearchText(),
            ),

          const Spacer(),

          const NotificationsIndicator(),
          const SizedBox(width: AppDimens.semiMedium),
          const NavbarAvatar(),
          const SizedBox(width: AppDimens.semiMedium)
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5), // Mueve la sombra hacia abajo
            blurRadius: 5, // Desenfoque de la sombra
            spreadRadius: 0, // Expansión de la sombra (se puede ajustar)
          ),
        ],
      );
}
