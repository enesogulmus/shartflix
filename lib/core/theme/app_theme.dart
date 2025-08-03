import 'package:flutter/material.dart';
import 'package:shartflix/core/utils/size_utils.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1F1F1F);
  static const Color secondaryColor = Color(0xFFE50914);
  static const Color backgroundColor = Color(0xFF090909);
  static const Color surfaceColor = Color(0xFF1F1F1F);
  static const Color textPrimaryColor = Color(0xFFFFFFFF);
  static const Color textSecondaryColor = Color(0x80FFFFFF);
  static const Color bonusColor = Color(0xFF6F060B);
  static const Color jetonColor = Color(0xFF5949E6);
  static const Color errorColor = Color(0xFFE50914);
  static const Color transparentColor = Colors.transparent;

  static TextStyle headline1 = TextStyle(fontSize: 20.h, fontWeight: FontWeight.w400, fontFamily: 'Poppins');

  static TextStyle headline2 = TextStyle(
    fontSize: 18.h,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    fontFamily: 'Poppins',
  );

  static TextStyle bodyText1 = TextStyle(
    fontSize: 15.h,
    fontWeight: FontWeight.w500,
    color: textPrimaryColor,
    fontFamily: 'Poppins',
  );

  static TextStyle bodyText2 = TextStyle(
    fontSize: 13.h,
    fontWeight: FontWeight.w400,
    color: textSecondaryColor,
    fontFamily: 'Poppins',
  );

  static TextStyle bodyText3 = TextStyle(
    fontSize: 12.h,
    fontWeight: FontWeight.w500,
    color: textSecondaryColor,
    fontFamily: 'Poppins',
  );

  static TextStyle bodyText4 = TextStyle(
    fontSize: 12.h,
    fontWeight: FontWeight.w400,
    color: textSecondaryColor,
    fontFamily: 'Poppins',
  );

  static TextStyle bodyText5 = TextStyle(
    fontSize: 12.h,
    fontWeight: FontWeight.w400,
    color: textPrimaryColor,
    fontFamily: 'Poppins',
  );

  static TextStyle bodyText6 = TextStyle(
    fontSize: 12.h,
    fontWeight: FontWeight.w500,
    color: textPrimaryColor,
    fontFamily: 'Poppins',
  );

  static TextStyle headline3 = TextStyle(
    fontSize: 13.h,
    fontWeight: FontWeight.w400,
    color: textPrimaryColor,
    fontFamily: 'Poppins',
  );

  static TextStyle bodyText7 = TextStyle(
    fontSize: 13.h,
    fontWeight: FontWeight.w700,
    color: textPrimaryColor,
    fontFamily: 'Poppins',
  );

  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor: textPrimaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
  );

  static InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.h),
        borderSide: BorderSide(color: AppTheme.textPrimaryColor.withAlpha(20), width: 1.h),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.h),
        borderSide: BorderSide(color: AppTheme.textPrimaryColor.withAlpha(20), width: 1.h),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.h),
        borderSide: BorderSide(color: AppTheme.textPrimaryColor, width: 2.h),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.h),
        borderSide: BorderSide(color: AppTheme.errorColor, width: 1.h),
      ),
      hintStyle: bodyText4,
      labelStyle: bodyText4,
      filled: true,
      fillColor: AppTheme.textPrimaryColor.withAlpha(10),
      contentPadding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: secondaryColor,
        secondary: secondaryColor,
        surface: backgroundColor,
        error: errorColor,
        onPrimary: textPrimaryColor,
        onSecondary: textPrimaryColor,
        onSurface: textPrimaryColor,
        onError: textPrimaryColor,
      ),
      textTheme: TextTheme(
        headlineLarge: headline1,
        headlineMedium: headline2,
        bodyLarge: bodyText1,
        bodyMedium: bodyText2,
        bodySmall: bodyText3,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButtonStyle),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textSecondaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textSecondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: secondaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColor),
        ),
        filled: true,
        fillColor: surfaceColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: bodyText1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: secondaryColor,
        unselectedItemColor: textSecondaryColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
