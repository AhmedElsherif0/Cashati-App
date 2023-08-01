import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'colors.dart';

class AppDecorations {
  static const duration600ms = Duration(milliseconds: 600);

  static BoxDecoration defBoxDecoration = BoxDecoration(
    color: AppColor.primaryColor,
    borderRadius: BorderRadius.circular(12.dp),
    border: Border.all(width: 1.dp, color: AppColor.primaryColor),
  );
  static BoxDecoration dTabBoxDecoration = BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(12.dp),
    border: Border.all(width: 1.dp, color: AppColor.white),
  );

  static BoxDecoration languageDecoration = BoxDecoration(
      color: AppColor.veryLightGrey, borderRadius: BorderRadius.circular(16.dp));

  static BoxDecoration decoratedTextDecoration = BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(16.dp),
  );
  static ShapeBorder dropDownCurrency = RoundedRectangleBorder(
      side: const BorderSide(color: AppColor.primaryColor, width: 0.8),
      borderRadius: BorderRadius.circular(12.dp));

}
