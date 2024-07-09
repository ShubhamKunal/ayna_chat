import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

MaterialStateProperty<Color?> buttonColor =
    MaterialStateProperty.resolveWith<Color?>(
  (Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return Colors.white;
    }
    return HexColor("#35518F");
  },
);
MaterialStateProperty<Color?> buttonColor2 =
    MaterialStateProperty.resolveWith<Color?>(
  (Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return HexColor("#3E60AD");
      // return Colors.white;
    }
    return HexColor("#3E60AD");
  },
);
