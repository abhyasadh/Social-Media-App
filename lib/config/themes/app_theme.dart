import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color.fromRGBO(176, 227, 245, 1);
  static const MaterialColor materialColor = MaterialColor(0xffff6c44, {
    50: Color(0xFFfff9e6),
    100: Color(0xFFfeecb4),
    200: Color(0xFFfddf82),
    300: Color(0xFFfcd24f),
    400: Color(0xFFF5BA04),
    500: Color(0xFFe2ab04),
    600: Color(0xFFb08503),
    700: Color(0xFF7d5f02),
    800: Color(0xFF4b3901),
    900: Color(0xFF191300),
  });
  static const Color darkScaffoldBackgroundColor = Color(0xFF000000);
  static const Color lightScaffoldBackgroundColor = Color(0xFFffffff);

  static const Color errorColor = Color(0xFFE94D4D);
  static const Color successColor = Color(0xFF71CC35);
  static const Color linkColor = Color(0xFF37B5DF);

  static const String fontFamily = 'Poppins';

  static getApplicationTheme(bool isDark) {
    return ThemeData(
        useMaterial3: true,
        fontFamily: fontFamily,
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: primaryColor,
        primarySwatch: materialColor,
        scaffoldBackgroundColor:
            isDark ? darkScaffoldBackgroundColor : lightScaffoldBackgroundColor,
        colorScheme: isDark
            ? const ColorScheme.dark(
                primary: Color(0xff303030),
                secondary: Color(0xff101010),
                tertiary: Color(0xfff3f3f3),
              )
            : const ColorScheme.light(
                primary: Color(0xfff3f3f3),
                secondary: Color(0xfffefefe),
                tertiary: Color(0xff303030),
              ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(16),
          suffixIconColor: primaryColor,
          errorStyle: const TextStyle(color: errorColor),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: errorColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: errorColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            padding:
                WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
            backgroundColor: WidgetStateProperty.all<Color>(
              primaryColor,
            ),
            fixedSize: WidgetStateProperty.all<Size>(
              const Size(double.infinity, 50),
            ),
          ),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
    );
  }
}
