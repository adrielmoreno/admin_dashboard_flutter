import 'package:flutter/material.dart';

import '../../../common/theme/constants/app_dimens.dart';

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
              height: AppDimens.semiBig,
            ),
            Text('Checking')
          ],
        ),
      ),
    );
  }
}
