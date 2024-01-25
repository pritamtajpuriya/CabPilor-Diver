import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 117, 199, 244);
const secondaryColor = Color(0xff51eec2);

final appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
      elevation: 2,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
    ),

    //Page Transitions

    // pageTransitionsTheme: PageTransitionsTheme(
    //   builders: kIsWeb
    //       ? {
    //           // No animations for every OS if the app running on the web
    //           for (final platform in TargetPlatform.values)
    //             platform: const NoTransitionsBuilder(),
    //         }
    //       : const {
    //           // handel other platforms you are targeting
    //         },
    // ),

    //Text color of the app
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        floatingLabelStyle: TextStyle(color: primaryColor),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
        ),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        )));
