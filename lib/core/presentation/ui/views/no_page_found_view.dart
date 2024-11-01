import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/theme/constants/app_dimens.dart';

class NoPageFoundView extends StatelessWidget {
  const NoPageFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '404 - Página no encontrada',
        style: GoogleFonts.montserratAlternates(
            fontSize: AppDimens.huge, fontWeight: FontWeight.bold),
      ),
    );
  }
}
