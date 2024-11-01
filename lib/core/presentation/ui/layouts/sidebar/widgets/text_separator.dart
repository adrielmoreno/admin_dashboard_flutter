import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/theme/constants/app_dimens.dart';

class TextSeparator extends StatelessWidget {
  final String text;

  const TextSeparator({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.medium),
      margin: const EdgeInsets.only(bottom: AppDimens.extraSmall),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          color: Colors.white.withOpacity(0.3),
          fontSize: AppDimens.semiMedium,
        ),
      ),
    );
  }
}
