import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'colors.dart';

class AppDecorations {

  static BoxDecoration defBoxDecoration = BoxDecoration(
    color: AppColor.primaryColor,
    borderRadius: BorderRadius.circular(12.sp),
    border: Border.all(width: 1.sp, color: AppColor.primaryColor),
  );

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
}
