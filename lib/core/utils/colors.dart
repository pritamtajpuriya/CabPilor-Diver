import 'package:flutter/material.dart';

class AppColors {
  static Color gray600 = fromHex('#6d6d6d');

  static Color gray700 = fromHex('#595959');

  static Color teal40033 = fromHex('#331db27e');

  static Color gray60001 = fromHex('#7f7979');

  static Color blueGray100 = fromHex('#d7d7d7');

  static Color redA70019 = fromHex('#19ff0000');

  static Color blueGray400 = fromHex('#888888');

  static Color gray800 = fromHex('#454645');

  static Color gray900 = fromHex('#242625');

  static Color gray90001 = fromHex('#1e1c1c');

  static Color lightBlue700 = fromHex('#0591bd');

  static Color teal50 = fromHex('#d2f0e5');

  static Color gray800Cc = fromHex('#cc454645');

  static Color gray300 = fromHex('#e0e0e0');

  static Color black9001e = fromHex('#1e000000');

  static Color teal400 = fromHex('#1db27e');

  static Color black90023 = fromHex('#23000000');

  static Color nevDefaultColor = fromHex('#AAAAAA');

  static Color greenA700 = fromHex('#0fa958');

  static Color black90033 = fromHex('#33000000');

  static Color black900 = fromHex('#000000');

  static Color teal40019 = fromHex('#191db27e');

  static Color blueGray700 = fromHex('#4f5150');

  static Color whiteA700 = fromHex('#ffffff');

  static Color redA700 = fromHex('#ff0000');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
