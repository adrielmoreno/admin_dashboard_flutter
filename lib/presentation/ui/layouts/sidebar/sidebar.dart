import 'package:flutter/material.dart';

import '../../../common/theme/constants/app_dimens.dart';
import '../../views/blank_view.dart';
import '../../views/dashboard_view.dart';
import '../../views/icons_view.dart';
import 'widgets/logo.dart';
import 'widgets/menu_item.dart';
import 'widgets/text_separator.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.sidemenuWidth,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: const [
          Logo(),
          SizedBox(height: AppDimens.huge),
          TextSeparator(text: 'main'),
          MenuItem(
            text: DashboardView.route,
            icon: Icons.compass_calibration_outlined,
          ),
          MenuItem(
            text: 'Orders',
            icon: Icons.shopping_cart_outlined,
          ),
          MenuItem(
            text: 'Analytic',
            icon: Icons.show_chart_outlined,
          ),
          MenuItem(
            text: 'Categories',
            icon: Icons.layers_outlined,
          ),
          MenuItem(
            text: 'Products',
            icon: Icons.dashboard_outlined,
          ),
          MenuItem(
            text: 'Discount',
            icon: Icons.attach_money_outlined,
          ),
          MenuItem(
            text: 'Customers',
            icon: Icons.people_alt_outlined,
          ),
          SizedBox(height: AppDimens.semiBig),
          TextSeparator(text: 'UI Elements'),
          MenuItem(
            text: IconsView.route,
            icon: Icons.list_alt_outlined,
          ),
          MenuItem(
            text: 'Marketing',
            icon: Icons.mark_email_read_outlined,
          ),
          MenuItem(
            text: 'Campaign',
            icon: Icons.note_add_outlined,
          ),
          MenuItem(
            text: BlankView.route,
            icon: Icons.post_add_outlined,
          ),
          SizedBox(height: AppDimens.extraHuge),
          TextSeparator(text: 'Exit'),
          MenuItem(
            text: 'Logout',
            icon: Icons.exit_to_app_outlined,
          ),
        ],
      ),
    );
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
