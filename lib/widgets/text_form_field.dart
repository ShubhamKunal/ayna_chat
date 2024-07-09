import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    switch (widget.obscureText) {
      case true:
        return SizedBox(
          height: 48,
          child: TextFormField(
            controller: widget.controller,
            obscureText: show,
            decoration: InputDecoration(
              filled: true,
              fillColor: HexColor("#FCFCFC"),
              hintText: widget.hintText,
              labelStyle: GoogleFonts.dmSans(fontSize: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  width: 2,
                  color: Colors.grey[300]!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  width: 2,
                  color: Colors.grey[300]!,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    show = !show;
                  });
                },
                icon: Icon(
                  show ? FeatherIcons.eye : FeatherIcons.eyeOff,
                ),
              ),
            ),
          ),
        );
      case false:
      default:
        return SizedBox(
          height: 48,
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              filled: true,
              fillColor: HexColor("#FCFCFC"),
              hintText: widget.hintText,
              labelStyle: GoogleFonts.dmSans(fontSize: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  width: 2,
                  color: Colors.grey[300]!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  width: 2,
                  color: Colors.grey[300]!,
                ),
              ),
            ),
          ),
        );
    }
  }
}
