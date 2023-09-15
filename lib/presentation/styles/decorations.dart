import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'colors.dart';

class AppDecorations {
  static const duration600ms = Duration(milliseconds: 600);
  static const duration400ms = Duration(milliseconds: 400);
  static const welcomeStops = [0.0, 0.087, 0.90, 1.5];

  static BoxDecoration defBoxDecoration = BoxDecoration(
    color: AppColor.primaryColor,
    borderRadius: const BorderRadius.all(Radius.circular(12)),
    border: Border.all(width: 1.dp, color: AppColor.primaryColor),
  );

  static AlignmentGeometry localizedAlignment =
      translator.activeLanguageCode == 'en' ? Alignment.topRight : Alignment.topLeft;

  static BoxDecoration dTabBoxDecoration(Color color) => BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(width: 1.dp, color: color),
      );

  static BorderRadius rGoalCardBar = const BorderRadius.only(
      topRight: Radius.circular(12), bottomRight: Radius.circular(12));

  static BorderRadius lGoalCardBar = const BorderRadius.only(
      topLeft: Radius.circular(12), bottomLeft: Radius.circular(12));

  static BoxDecoration homeCard = const BoxDecoration(
      color: AppColor.primaryColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)));

  static BoxDecoration languageDecoration = const BoxDecoration(
      color: AppColor.veryLightGrey,
      borderRadius: BorderRadius.all(Radius.circular(16)));

  static BoxDecoration decoratedTextDecoration({double radius = 16}) => BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      );
  static ShapeBorder dropDownCurrency = const RoundedRectangleBorder(
      side: BorderSide(color: AppColor.primaryColor, width: 0.8),
      borderRadius: BorderRadius.all(Radius.circular(12)));

  static BorderRadius rightDrawer = const BorderRadius.only(
      bottomLeft: Radius.circular(20), topLeft: Radius.circular(20));

  static BorderRadius liftDrawer = const BorderRadius.only(
      bottomRight: Radius.circular(20), topRight: Radius.circular(20));

  static BoxDecoration subCategory(bool isEqual) => BoxDecoration(
        color: isEqual ? AppColor.primaryColor : AppColor.white,
        shape: BoxShape.circle,
        border: Border.all(color: isEqual ? AppColor.white : AppColor.primaryColor),
      );

  static editTextDecoration(backGroundColor) => BoxDecoration(
      color: backGroundColor ?? AppColor.primaryColor.withOpacity(0.25),
      borderRadius: const BorderRadius.all(Radius.circular(16)));
}
