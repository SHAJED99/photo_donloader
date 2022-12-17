import 'package:flutter/material.dart';

Color colorFromHex(String colorHex) {
  if (colorHex.isEmpty) {
    return Colors.white;
  } else {
    return Color(int.parse("0x${colorHex.replaceAll("#", "")}")).withOpacity(1.0);
  }
}
