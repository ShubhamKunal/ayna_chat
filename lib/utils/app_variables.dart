import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

String config = "ECHO";

WidgetStateProperty<Color?> buttonColor =
    WidgetStateProperty.resolveWith<Color?>(
  (Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return Colors.white;
    }
    return HexColor("#35518F");
  },
);
WidgetStateProperty<Color?> buttonColor2 =
    WidgetStateProperty.resolveWith<Color?>(
  (Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return HexColor("#3E60AD");
      // return Colors.white;
    }
    return HexColor("#3E60AD");
  },
);
