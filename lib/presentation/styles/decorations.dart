import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'colors.dart';

class AppDecorations {
  static const duration600ms = Duration(milliseconds: 600);

  static BoxDecoration defBoxDecoration = BoxDecoration(
    color: AppColor.primaryColor,
    borderRadius: BorderRadius.circular(12.sp),
    border: Border.all(width: 1.sp, color: AppColor.primaryColor),
  );

  static BoxDecoration languageDecoration = BoxDecoration(
      color: AppColor.veryLightGrey, borderRadius: BorderRadius.circular(16.sp));

  static BoxDecoration decoratedTextDecoration = BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(16.sp),
  );
  static ShapeBorder dropDownCurrency = RoundedRectangleBorder(
      side: const BorderSide(color: AppColor.primaryColor, width: 0.8),
      borderRadius: BorderRadius.circular(12.sp));

}
