import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/styles/styles.dart';

class AppTheme {
  static final AppStyle _appStyle = AppStyle();
  static ThemeData lightThemeMode = ThemeData(
      pageTransitionsTheme: _pageTransitionsTheme(),
      colorScheme: const ColorScheme.light(
        primary: AppColor.primaryColor,
        onSurface: AppColor.pineGreen,
      ),
      fontFamily: 'poppins',
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        toolbarHeight: 2.h,
        titleTextStyle: _appStyle.appBarTitleTextStyle(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: _appStyle.systemUiStatusBarStyle(),
      ),
      textTheme: TextTheme(
          headline1: _appStyle.headline1Theme(),
          headline2: _appStyle.headline2Theme(),
          headline3: _appStyle.headline3Theme(),
          headline4: _appStyle.headline4Theme(),
          headline5: _appStyle.headline5Theme(),
          headline6: _appStyle.headline6Theme(),
          bodyText1: _appStyle.bodyText1Theme(),
          bodyText2: _appStyle.bodyText2Theme(),
          subtitle1: _appStyle.subtitle1Theme(),
          subtitle2: _appStyle.subtitle2Theme(),
          caption: _appStyle.captionTheme(),
          overline: _appStyle.overLineTheme()),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          backgroundColor: AppColor.primaryColor,
          textStyle:  TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.white,
              letterSpacing: -0.3),
        ),
      )
      // inputDecorationTheme: const InputDecorationTheme(
      //   enabledBorder: UnderlineInputBorder(
      //     borderSide: BorderSide(color: Colors.white),
      //   ),
      //   focusedBorder: UnderlineInputBorder(
      //     borderSide: BorderSide(color: Colors.white),
      //   ),
      // ),
      );

  static PageTransitionsTheme _pageTransitionsTheme() {
    return const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    );
  }
}
