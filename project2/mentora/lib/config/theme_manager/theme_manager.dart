import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentora_app/core/colors_manager.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
      iconTheme: IconThemeData(
          color: ColorsManager.black
      ),
    scaffoldBackgroundColor: ColorsManager.white,
    secondaryHeaderColor: ColorsManager.black,
    shadowColor: ColorsManager.shadow,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.itim(
        fontSize: 28.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.black,
      ),
      bodyMedium: GoogleFonts.itim(
        fontSize: 20.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.black,
      ),
      bodyLarge: GoogleFonts.itim(
        fontSize: 28.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.black,
      ),
      titleMedium: GoogleFonts.itim(
        fontSize: 24.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.blue,
      ),
      titleSmall: GoogleFonts.itim(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.blue,
      ),
      bodySmall: GoogleFonts.itim(
        fontSize: 16.sp,
        color: ColorsManager.black.withOpacity(0.7),
        fontWeight: FontWeight.normal,
      ),
      labelLarge: GoogleFonts.itim(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: ColorsManager.white,
      ),
      labelMedium: GoogleFonts.itim(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: ColorsManager.black,
      ),
      displayMedium: GoogleFonts.itim(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: ColorsManager.white,
      ),
      displaySmall: GoogleFonts.itim(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.grey,
      ),
      labelSmall: GoogleFonts.itim(
        fontSize: 16.sp,
        color: ColorsManager.black,
        fontWeight: FontWeight.normal,
      ),
      headlineSmall: GoogleFonts.itim(
        fontSize: 16.sp,
        color: ColorsManager.blue,
        fontWeight: FontWeight.normal,
      ),
      headlineLarge: GoogleFonts.itim(
        fontSize: 28.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.blue,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.itim(
        fontSize: 16.sp,
        color: ColorsManager.black.withOpacity(0.7),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: ColorsManager.black.withOpacity(0.4)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: ColorsManager.black.withOpacity(0.4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: ColorsManager.black.withOpacity(0.4)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: ColorsManager.blue),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorsManager.white,
        backgroundColor: ColorsManager.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        textStyle: GoogleFonts.itim(fontSize: 20.sp),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: ColorsManager.blue,
      unselectedItemColor: ColorsManager.unselectedIcon,
      backgroundColor: ColorsManager.white,
      type: BottomNavigationBarType.fixed,
    ),
      primaryColorDark: ColorsManager.unselectedIcon
  );
  static final ThemeData dark = ThemeData(
    iconTheme: IconThemeData(
      color: ColorsManager.white
    ),
    secondaryHeaderColor: ColorsManager.white,
    shadowColor: ColorsManager.shadowDark,
    scaffoldBackgroundColor: ColorsManager.dark,
    appBarTheme: AppBarTheme(backgroundColor: ColorsManager.dark),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.itim(
        fontSize: 28.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.white,
      ),
      bodyMedium: GoogleFonts.itim(
        fontSize: 20.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.white,
      ),
      bodyLarge: GoogleFonts.itim(
        fontSize: 28.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.white,
      ),
      titleMedium: GoogleFonts.itim(
        fontSize: 24.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.blue,
      ),
      titleSmall: GoogleFonts.itim(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.blue,
      ),
      bodySmall: GoogleFonts.itim(
        fontSize: 16.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: GoogleFonts.itim(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: ColorsManager.white,
      ),
      labelMedium: GoogleFonts.itim(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: ColorsManager.white,
      ),
      displayMedium: GoogleFonts.itim(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: ColorsManager.white,
      ),
      displaySmall: GoogleFonts.itim(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.white,
      ),
      labelSmall: GoogleFonts.itim(
        fontSize: 16.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.normal,
      ),
      headlineSmall: GoogleFonts.itim(
        fontSize: 16.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.normal,
      ),
      headlineLarge: GoogleFonts.itim(
        fontSize: 28.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.itim(fontSize: 16.sp, color: ColorsManager.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: ColorsManager.darkGreyBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: ColorsManager.darkGreyBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: ColorsManager.darkGreyBorder),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
      suffixIconColor: ColorsManager.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: ColorsManager.blue),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorsManager.white,
        backgroundColor: ColorsManager.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        textStyle: GoogleFonts.itim(fontSize: 20.sp),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: ColorsManager.blue,
      unselectedItemColor: ColorsManager.white,
      backgroundColor: ColorsManager.dark,
      type: BottomNavigationBarType.fixed,
    ),
    primaryColorDark: ColorsManager.white
  );
}
