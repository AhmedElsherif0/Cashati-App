import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

class SettingCardLayout extends StatelessWidget {
   SettingCardLayout({Key? key, required this.settingChild}) : super(key: key);
  final Widget settingChild;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15.sp),
        decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(color: AppColor.grey.withOpacity(.4)),
            borderRadius: BorderRadius.circular(24.sp),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, 1),
                color: AppColor.grey.withOpacity(0.4),
              ),
              // BoxShadow(
              //   blurRadius: 60,
              //   spreadRadius: 0.5,
              //   offset: Offset(0,0),
              //   color: AppColor.grey,
              //
              // ),
            ]),
    child: this.settingChild,
    );
  }
}
