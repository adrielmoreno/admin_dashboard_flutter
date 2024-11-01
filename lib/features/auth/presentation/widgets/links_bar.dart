import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/presentation/common/buttons/link_text.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);

    return Container(
        color: Colors.black,
        height: breakpoint.largerThan(DESKTOP)
            ? breakpoint.screenHeight * 0.07
            : null,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            LinkText(text: 'About', onPressed: () => log('about')),
            const LinkText(text: 'Help Center'),
            const LinkText(text: 'Terms of Service'),
            const LinkText(text: 'Privacy Policy'),
            const LinkText(text: 'Cookie Policy'),
            const LinkText(text: 'Ads info'),
            const LinkText(text: 'Blog'),
            const LinkText(text: 'Status'),
            const LinkText(text: 'Careers'),
            const LinkText(text: 'Brand Resources'),
            const LinkText(text: 'Advertising'),
            const LinkText(text: 'Marketing'),
          ],
        ));
  }
}
