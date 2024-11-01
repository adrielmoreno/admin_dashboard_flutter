import 'package:flutter/material.dart';

import '../theme/constants/app_dimens.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final bool isTextWhite;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = Colors.blue,
    this.isFilled = false,
    this.isTextWhite = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.big))),
          side: WidgetStateProperty.all(BorderSide(color: color)),
          backgroundColor: WidgetStateProperty.all(
              isFilled ? color.withOpacity(0.3) : Colors.transparent),
        ),
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.semiBig, vertical: AppDimens.semiMedium),
          child: Text(
            text,
            style: TextStyle(
                fontSize: AppDimens.medium,
                color: isTextWhite ? Colors.white : color),
          ),
        ));
  }
}
