import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  String fontFamily,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

//Description Text Style

TextStyle getDescriptionStyle(
    {double fontSize = FontSize.s12, Color color = Colors.grey}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWieghtManager.regular,
    color,
  );
}

//Regular Text Style
TextStyle getRegularStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWieghtManager.regular,
    color,
  );
}

//Light Text Style
TextStyle getLightStyle({
  double fontSize = FontSize.s12,
  Color color = Colors.black,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWieghtManager.light,
    color,
  );
}

//Medium Text Style
TextStyle getMediumStyle({
  double fontSize = FontSize.s12,
  Color color = Colors.black,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWieghtManager.medium,
    color,
  );
}

//Semi Bold Text Style
TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWieghtManager.semiBold,
    color,
  );
}

//Bold Text Style
TextStyle getBoldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWieghtManager.bold,
    color,
  );
}
