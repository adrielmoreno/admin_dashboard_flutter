import 'package:flutter/material.dart';

import '../theme/constants/app_dimens.dart';

class LinkText extends StatefulWidget {
  final String text;
  final Function? onPressed;

  const LinkText({super.key, required this.text, this.onPressed});

  @override
  State createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) widget.onPressed!();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppDimens.semiMedium, vertical: AppDimens.extraSmall),
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: AppDimens.medium,
                color: Colors.grey[700],
                decoration:
                    isHover ? TextDecoration.underline : TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
