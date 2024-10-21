import 'package:flutter/material.dart';

class AppColors {
  // Светлая тема
  static const Color lightPrimary = Color(0xFF3DB0D4);
  static const Color lightBgColor = Color(0xFFFFFFFF);
  static const Color lightBlack1Color = Color(0xFFFFFFFF);
  static const Color lightMenuIcon = Color(0xFF9EA6B2);
  static const Color lightBorderMenu = Color(0xFFE0E4EC);
  static const Color lightIconBg = Color(0xFFEEF1F6);
  static const Color lightSecondary = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF111419);
  static const Color lightSecondButton =
      Color(0xFF4CAF50); // Цвет для второй кнопки в светлой теме

  // Темная тема
  static const Color darkPrimary = Color(0xFF3DB0D4);
  static const Color darkBgColor = Color(0xFF111419);
  static const Color darkBlack1Color = Color(0xFF1D2329);
  static const Color darkMenuIcon = Color(0xFF5F656E);
  static const Color darkBorderMenu = Color(0xFF212730);
  static const Color darkIconBg = Color(0xFF1D2329);
  static const Color darkSecondary = Color(0xFF1E2229);
  static const Color darkText = Colors.white;
  static const Color darkSecondButton =
      Color(0xFFBB86FC); // Цвет для второй кнопки в темной теме

  static Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkPrimary
        : lightPrimary;
  }

  static Color getBgColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBgColor
        : lightBgColor;
  }

  static Color getIconBgColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkIconBg
        : lightIconBg;
  }

  static Color getBorderMenuColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorderMenu
        : lightBorderMenu;
  }

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? lightBgColor
        : darkBgColor;
  }

  static Color getMenuIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? lightMenuIcon
        : darkMenuIcon;
  }

  static Color getButtonTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBgColor
        : lightBgColor;
  }

  static Color getBlack1Color(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBlack1Color
        : lightBlack1Color;
  }

  static Color getSecondButtonColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSecondButton
        : lightSecondButton;
  }
}
