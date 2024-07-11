import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ayna_chat/utils/app_variables.dart' as values;
import 'package:hexcolor/hexcolor.dart';

class CustomSmallButton extends StatelessWidget {
  final dynamic text;
  final Function() onPressed;
  const CustomSmallButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: values.buttonColor,
        fixedSize: WidgetStateProperty.all<Size>(
          const Size.fromHeight(35),
        ),
      ),
      onPressed: onPressed,
      child: (text.runtimeType.toString() == "String")
          ? Text(
              text,
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: HexColor("#FFFFFF"),
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          : text,
    );
  }
}
