import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.color = Colors.blue,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(const StadiumBorder()),
        side: WidgetStateProperty.all(BorderSide(color: color)),
        overlayColor: WidgetStateProperty.all(color.withOpacity(0.3)),
        backgroundColor: WidgetStateProperty.all(color.withOpacity(0.5)),
      ),
      onPressed: () => onPressed(),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          Text(text, style: const TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}
