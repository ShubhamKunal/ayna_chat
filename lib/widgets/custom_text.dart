import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomText extends StatelessWidget {
  final double size;
  final String text;
  const CustomText({
    super.key,
    required this.text,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
          fontSize: size + 0.05,
          color: HexColor("#2C3351"),
          fontWeight: (size >= 18) ? FontWeight.w500 : FontWeight.w400,
        ),
      ),
    );
  }
}
