import 'package:flutter/material.dart';

// Flutter
extension WidgetExtensions on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ));
  }

  void showSnackBarError(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ));
  }

  Future<DateTime?> selectedDatePicker() async {
    return await showDatePicker(
      context: this,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
  }
}

// Dart
extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
