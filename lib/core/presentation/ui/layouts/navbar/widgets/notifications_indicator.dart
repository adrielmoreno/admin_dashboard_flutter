import 'package:flutter/material.dart';

class NotificationsIndicator extends StatelessWidget {
  const NotificationsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Badge(
      child: Icon(Icons.notifications_none_outlined, color: Colors.grey),
    );
  }
}
