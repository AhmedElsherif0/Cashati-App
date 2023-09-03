import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'colors.dart';

class AppDecorations {
  static const duration600ms = Duration(milliseconds: 600);
  static const duration400ms = Duration(milliseconds: 400);

  static BoxDecoration defBoxDecoration = BoxDecoration(
    color: AppColor.primaryColor,
    borderRadius: BorderRadius.circular(12.dp),
    border: Border.all(width: 1.dp, color: AppColor.primaryColor),
  );

  static BoxDecoration dTabBoxDecoration(Color color) => BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.dp),
        border: Border.all(width: 1.dp, color: color),
      );

  static BorderRadius rGoalCardBar = BorderRadius.only(
      topRight: Radius.circular(10.dp), bottomRight: Radius.circular(10.dp));

  static BorderRadius lGoalCardBar = BorderRadius.only(
      topLeft: Radius.circular(10.dp), bottomLeft: Radius.circular(10.dp));

  static BoxDecoration homeCard = BoxDecoration(
      color: AppColor.primaryColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.dp), topRight: Radius.circular(40.dp)));

  static BoxDecoration languageDecoration = BoxDecoration(
      color: AppColor.veryLightGrey, borderRadius: BorderRadius.circular(16.dp));

  static BoxDecoration decoratedTextDecoration = BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(16.dp),
  );
  static ShapeBorder dropDownCurrency = RoundedRectangleBorder(
      side: const BorderSide(color: AppColor.primaryColor, width: 0.8),
      borderRadius: BorderRadius.circular(12.dp));

  static BorderRadius rightDrawer = BorderRadius.only(
      bottomLeft: Radius.circular(20.dp), topLeft: Radius.circular(20.dp));

  static BorderRadius liftDrawer = BorderRadius.only(
      bottomRight: Radius.circular(20.dp), topRight: Radius.circular(20.dp));

  static BoxDecoration subCategory(bool isEqual) => BoxDecoration(
        color: isEqual ? AppColor.primaryColor : AppColor.white,
        shape: BoxShape.circle,
        border: Border.all(color: isEqual ? AppColor.white : AppColor.primaryColor),
      );
}
