import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

customButton(
    {required String iconName, required String text, int color = 0xff000000}) {
  return SizedBox(
    child: Row(
      children: [
        SvgPicture.asset('assets/svg/$iconName.svg', width: 17),
        const SizedBox(width: 5),
        Text(text,
            style: GoogleFonts.inter(
                fontSize: 12,
                color: Color(color),
                fontWeight: FontWeight.normal))
      ],
    ),
  );
}
