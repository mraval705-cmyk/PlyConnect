import 'package:flutter/material.dart';

/// Every colour used in the PlyConnect app is written here and nowhere else.
///
/// If a colour has to be changed, change it only in this file and the whole
/// app will use the new colour. This is what the teacher asked for.
class ColorResources {
  // Base colours
  static const Color background = Color(0xFFFBF9F8);
  static const Color primary = Color(0xFF523826);
  static const Color button = Color(0xFF6B4F3B);

  // Text colours
  static const Color heading = Color(0xFF1B1C1C);
  static const Color text = Color(0xFF4F453E);
  static const Color lightText = Color(0xFF81756D);

  // Supporting colours
  static const Color border = Color(0xFFD3C4BB);
  static const Color buttonText = Color(0xFFE9C2A9);
  static const Color white = Colors.white;

  // Colours used for status text
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFE65100);
  static const Color danger = Color(0xFFC62828);
  static const Color info = Color(0xFF1565C0);
}
