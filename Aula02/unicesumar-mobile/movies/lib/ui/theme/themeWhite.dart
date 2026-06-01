import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors - Tema Claro
const screenBackground = Color(0xFFFFFFFF);
const searchBarBackground = Color(0xFFF5F5F5);
const primaryButton = Color(0xFF111111);
const posterBorder = Color(0xFFE0E0E0);
const buttonGrey = Color(0xFF757575);

var roboto = GoogleFonts.roboto();

var largeTitle = roboto.copyWith(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black);
var heading1 = roboto.copyWith(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black);
var heading2 = roboto.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black);
var body1Regular = roboto.copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);
var body1Bold = roboto.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black);
var body2Regular = roboto.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);
var body2Bold = roboto.copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black);
var caption = roboto.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black);
var body3Regular = roboto.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black);
var body3Bold = roboto.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black);
var verySmallText = roboto.copyWith(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black);

ThemeData createThemeWhite() {
  return ThemeData(
    brightness: Brightness.light, // ✅ define o tema como claro
    scaffoldBackgroundColor: screenBackground,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      secondary: buttonGrey,
      surface: searchBarBackground,
    ),
    textTheme: Typography.material2021().englishLike.copyWith(
      headlineLarge: heading1,
      headlineMedium: heading2,
      headlineSmall: body2Regular,
      titleLarge: largeTitle,
      titleMedium: heading2,
      titleSmall: body2Bold,
      bodyLarge: body1Regular,
      bodyMedium: body2Regular,
      bodySmall: body3Regular,
      labelLarge: body1Bold,
      labelMedium: body2Bold,
      labelSmall: caption,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black, // ✅ ícones e texto escuros
      elevation: 1,
      shadowColor: posterBorder,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: searchBarBackground,
      labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: Colors.black);
        }
        return const TextStyle(color: buttonGrey);
      }),
      iconTheme: WidgetStateProperty.all(
        const IconThemeData(color: Colors.black),
      ),
      indicatorColor: posterBorder,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: searchBarBackground,
      selectedItemColor: Colors.black,
      unselectedItemColor: buttonGrey,
      showUnselectedLabels: true,
    ),
  );
}