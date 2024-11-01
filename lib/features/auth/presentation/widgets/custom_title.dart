import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/common/theme/constants/app_dimens.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.semiBig),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/twitter_white_logo.png',
            width: AppDimens.huge,
            height: AppDimens.huge,
          ),
          const SizedBox(height: AppDimens.semiBig),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'Happening Now',
              style: GoogleFonts.montserratAlternates(
                  fontSize: AppDimens.extraHuge,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
