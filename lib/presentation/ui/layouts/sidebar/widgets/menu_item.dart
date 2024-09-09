import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../external/di/inject.dart';
import '../../../../common/extensions/extenssions.dart';
import '../../../../common/theme/constants/app_dimens.dart';
import '../../../../providers/sidemenu_provider.dart';

class MenuItem extends StatefulWidget {
  final String text;
  final IconData icon;

  const MenuItem({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  State createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  final sideMenuProvider = getIt<SideMenuProvider>();
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: sideMenuProvider,
        builder: (context, _) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            color: isHovered
                ? Colors.white.withOpacity(0.1)
                : sideMenuProvider.currentPage == widget.text
                    ? Colors.white.withOpacity(0.1)
                    : Colors.transparent,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: sideMenuProvider.currentPage == widget.text
                    ? null
                    : () => _navigateTo(widget.text),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.big,
                    vertical: AppDimens.small,
                  ),
                  child: MouseRegion(
                    onEnter: (_) => setState(() => isHovered = true),
                    onExit: (_) => setState(() => isHovered = false),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(widget.icon, color: Colors.white.withOpacity(0.3)),
                        const SizedBox(width: AppDimens.semiMedium),
                        Text(
                          widget.text.capitalize(),
                          style: GoogleFonts.roboto(
                              fontSize: AppDimens.medium,
                              color: Colors.white.withOpacity(0.8)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _navigateTo(String route) {
    // if (route == DashboardView.route) {
    //   context.go('/${DashboardView.route}');
    // } else {
    context.replace('/$route');
    // }
    SideMenuProvider.closeMenu();
  }
}
