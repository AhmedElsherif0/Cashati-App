import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/styles/colors.dart';

ThemeData lightThemeMode = ThemeData(
  fontFamily: 'poppins',
  appBarTheme:  AppBarTheme(
    elevation: 0.0,
    titleTextStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColor.primaryColor),
    centerTitle: true,
    backgroundColor: Colors.transparent,
  ),
  textTheme: TextTheme(
      headline1: TextStyle(
          fontWeight: FontWeight.w600, color: AppColor.black, fontSize: 32),
      headline2: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColor.pineGreen,
          letterSpacing: -0.3),
      headline3: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.pineGreen),
      headline4: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
          color: AppColor.primaryColor, letterSpacing: -0.3),
      headline5: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColor.pineGreen),
      headline6: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,
          color: AppColor.primaryColor),
      bodyText1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.white,
          letterSpacing: -0.3),
      bodyText2: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
          letterSpacing: -0.3),
      subtitle1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColor.grey,
      )),
  // inputDecorationTheme: const InputDecorationTheme(
  //   enabledBorder: UnderlineInputBorder(
  //     borderSide: BorderSide(color: Colors.white),
  //   ),
  //   focusedBorder: UnderlineInputBorder(
  //     borderSide: BorderSide(color: Colors.white),
  //   ),
  // ),
);
