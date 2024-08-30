import 'package:flutter/material.dart';

import 'widgets/logo.dart';
import 'widgets/menu_item.dart';
import 'widgets/text_separator.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'main'),
          MenuItem(
              text: 'Dashboard',
              icon: Icons.compass_calibration_outlined,
              onPressed: () {},
              isActive: false),
          MenuItem(
              text: 'Orders',
              icon: Icons.shopping_cart_outlined,
              onPressed: () {}),
          MenuItem(
              text: 'Analytic',
              icon: Icons.show_chart_outlined,
              onPressed: () {}),
          MenuItem(
              text: 'Categories',
              icon: Icons.layers_outlined,
              onPressed: () {}),
          MenuItem(
              text: 'Products',
              icon: Icons.dashboard_outlined,
              onPressed: () {}),
          MenuItem(
              text: 'Discount',
              icon: Icons.attach_money_outlined,
              onPressed: () {}),
          MenuItem(
              text: 'Customers',
              icon: Icons.people_alt_outlined,
              onPressed: () {}),
          const SizedBox(height: 30),
          const TextSeparator(text: 'UI Elements'),
          MenuItem(
            text: 'Icons',
            icon: Icons.list_alt_outlined,
            onPressed: () {},
            isActive: false,
          ),
          MenuItem(
              text: 'Marketing',
              icon: Icons.mark_email_read_outlined,
              onPressed: () {}),
          MenuItem(
              text: 'Campaign',
              icon: Icons.note_add_outlined,
              onPressed: () {}),
          MenuItem(
            text: 'Black',
            icon: Icons.post_add_outlined,
            onPressed: () {},
            isActive: false,
          ),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Exit'),
          MenuItem(
              text: 'Logout',
              icon: Icons.exit_to_app_outlined,
              onPressed: () {}),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xff092044),
        Color(0xff092042),
      ]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
