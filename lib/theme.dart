import 'package:flutter/material.dart';

const Color primaryBgClr = Color.fromRGBO(236, 239, 251, 1);
const Color actionBgClr = Color.fromRGBO(101, 60, 246, 1);
const Color primaryTxtClr = Color.fromRGBO(46, 58, 89, 1);
const Color secondaryTxtClr = Color.fromRGBO(151, 162, 192, 1);
const Color shadowClr = Color.fromRGBO(101, 60, 246, 0.15);
const Color borderClr = Color.fromRGBO(205, 212, 229, 1);

class Themes {
  static const TextStyle subheading = TextStyle(
      color: secondaryTxtClr, fontSize: 18, fontWeight: FontWeight.w600);

  static const TextStyle heading = TextStyle(
      color: primaryTxtClr, fontSize: 28, fontWeight: FontWeight.w600);

  static const TextStyle inputTitle = TextStyle(
      color: primaryTxtClr, fontSize: 16, fontWeight: FontWeight.w600);

  static const TextStyle mutedTxt =
      TextStyle(color: secondaryTxtClr, fontSize: 14);

  static const TextStyle mutedTxtSm =
      TextStyle(color: secondaryTxtClr, fontSize: 12);

  static const TextStyle taskName = TextStyle(
      color: primaryTxtClr, fontSize: 16, fontWeight: FontWeight.w600);
}
