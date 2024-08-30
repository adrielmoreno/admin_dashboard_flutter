import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/theme/constants/app_dimens.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.big),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.bubble_chart_outlined, color: Color(0xff7A6BF5)),
          const SizedBox(width: AppDimens.semiMedium),
          Text(
            'Admin',
            style: GoogleFonts.montserratAlternates(
                fontSize: AppDimens.semiBig,
                fontWeight: FontWeight.w200,
                color: Colors.white),
          )
        ],
      ),
    );
  }
}
