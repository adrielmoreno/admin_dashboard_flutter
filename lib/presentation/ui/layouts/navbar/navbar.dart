import 'package:flutter/material.dart';

import '../../../providers/sidemenu_provider.dart';
import 'widgets/navbar_avatar.dart';
import 'widgets/notifications_indicator.dart';
import 'widgets/search_text.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          if (size.width < 700)
            const IconButton(
              icon: Icon(Icons.menu_outlined),
              onPressed: SideMenuProvider.openMenu,
            ),

          const SizedBox(width: 5),

          // Search input
          if (size.width > 390)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: const SearchText(),
            ),

          const Spacer(),

          const NotificationsIndicator(),
          const SizedBox(width: 10),
          const NavbarAvatar(),
          const SizedBox(width: 10)
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
