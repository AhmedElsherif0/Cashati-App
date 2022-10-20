import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'colors.dart';

class AppStyle {
  TextStyle headline1Theme() => const TextStyle(
      fontWeight: FontWeight.w600, color: AppColor.black, fontSize: 32);

  TextStyle headline2Theme() => TextStyle(
      fontSize: 20.6.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.pineGreen,
      letterSpacing: -0.3);

  TextStyle headline3Theme() => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColor.pineGreen,
      );

  TextStyle headline4Theme() => TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryColor,
      letterSpacing: -0.3);

  TextStyle headline5Theme() => TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColor.pineGreen);

  TextStyle headline6Theme() => TextStyle(
      fontSize: 12.4.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryColor);

  TextStyle bodyText1Theme() => TextStyle(
      fontSize: 12.4.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.white,
      letterSpacing: -0.3);

  TextStyle bodyText2Theme() => TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryColor,
      letterSpacing: -0.3);

  TextStyle subtitle1Theme() => TextStyle(
      fontSize: 12.4.sp,
      fontWeight: FontWeight.w300,
      color: AppColor.pineGreen);

  TextStyle subtitle2Theme() => const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: AppColor.grey);

  TextStyle captionTheme() => TextStyle(
      fontSize: 8.sp, fontWeight: FontWeight.w500, color: AppColor.pineGreen);

  TextStyle appBarTitleTextStyle() => TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryColor);

  SystemUiOverlayStyle systemUiStatusBarStyle() => const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark);
}

// BoxDecoration defBoxDecoration = BoxDecoration(
//     color: AppColor.white,
//     shape: BoxShape.rectangle,
//     borderRadius: BorderRadius.circular(16.0),
//     boxShadow: const [BoxShadow(color: Colors.black26)]);

// BoxDecoration maniBocDecoration = BoxDecoration(
//   color: AppColor.white,
//   boxShadow: [
//     BoxShadow(
//         color: Colors.grey.withOpacity(0.6),
//         offset: Offset(0.0, 0.5.h),
//         blurRadius: 2.0),
//   ],
//   borderRadius: BorderRadius.circular(5),
// );
