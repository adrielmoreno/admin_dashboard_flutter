import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/di/inject.dart';
import '../../../../../features/auth/presentation/view_model/auth_view_model.dart';
import '../../../../../features/category/presentation/categories_view.dart';
import '../../../../../features/product/presentation/products_view.dart';
import '../../../common/theme/constants/app_dimens.dart';
import '../../views/blank_view.dart';
import '../../views/dashboard_view.dart';
import '../../views/icons_view.dart';
import 'providers/sidemenu_provider.dart';
import 'widgets/logo.dart';
import 'widgets/menu_item.dart';
import 'widgets/text_separator.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final _autViewModel = getIt<AuthViewModel>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.sidemenuWidth,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(height: AppDimens.huge),
          const TextSeparator(text: 'main'),
          MenuItem(
            text: DashboardView.route,
            icon: Icons.compass_calibration_outlined,
            onPressed: () => _navigateTo(DashboardView.route),
          ),
          const MenuItem(
            text: 'Orders',
            icon: Icons.shopping_cart_outlined,
          ),
          const MenuItem(
            text: 'Analytic',
            icon: Icons.show_chart_outlined,
          ),
          MenuItem(
            text: CategoriesView.route,
            icon: Icons.layers_outlined,
            onPressed: () => _navigateTo(CategoriesView.route),
          ),
          MenuItem(
            text: ProductsView.route,
            icon: Icons.dashboard_outlined,
            onPressed: () => _navigateTo(ProductsView.route),
          ),
          const MenuItem(
            text: 'Discount',
            icon: Icons.attach_money_outlined,
          ),
          const MenuItem(
            text: 'Users',
            icon: Icons.people_alt_outlined,
          ),
          const SizedBox(height: AppDimens.semiBig),
          const TextSeparator(text: 'UI Elements'),
          MenuItem(
            text: IconsView.route,
            icon: Icons.list_alt_outlined,
            onPressed: () => _navigateTo(IconsView.route),
          ),
          const MenuItem(
            text: 'Marketing',
            icon: Icons.mark_email_read_outlined,
          ),
          const MenuItem(
            text: 'Campaign',
            icon: Icons.note_add_outlined,
          ),
          MenuItem(
            text: BlankView.route,
            icon: Icons.post_add_outlined,
            onPressed: () => _navigateTo(BlankView.route),
          ),
          const SizedBox(height: AppDimens.extraHuge),
          const TextSeparator(text: 'Exit'),
          MenuItem(
            text: 'Logout',
            icon: Icons.exit_to_app_outlined,
            onPressed: () async {
              await _autViewModel.signOut();
              SideMenuProvider.closeMenu();
            },
          ),
        ],
      ),
    );
  }

  void _navigateTo(String route) {
    context.goNamed(route);
    SideMenuProvider.closeMenu();
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff092044),
            Color(0xff092042),
          ]),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: AppDimens.small,
            )
          ]);
}
