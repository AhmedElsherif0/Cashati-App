import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/styles/styles.dart';

class AppTheme {
  static final AppStyle _appStyle = AppStyle();

  static ThemeData lightThemeMode = ThemeData(
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
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        backgroundColor:AppColor.primaryColor,
        textStyle: TextStyle(color: AppColor.white)
      )
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
}
