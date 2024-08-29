import 'package:flutter/material.dart';

class SplashLayuot extends StatelessWidget {
  const SplashLayuot({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text('Checking')
          ],
        ),
      ),
    );
  }
}
