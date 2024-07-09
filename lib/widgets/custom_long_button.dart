import 'package:ayna_chat/widgets/custom_colored_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomLongButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool bright;
  const CustomLongButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.bright,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      padding: const EdgeInsets.only(right: 16, left: 16),
      decoration: BoxDecoration(
        color: HexColor("#3E60AD"),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomColoredText(
              text: text,
              hexColor: "#FFFFFF",
              size: 16,
              weight: 500,
            ),
            const Icon(
              PhosphorIcons.arrow_right,
              size: 24,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
