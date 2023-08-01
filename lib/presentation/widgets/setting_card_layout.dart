import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../styles/colors.dart';

class SettingCardLayout extends StatelessWidget {
  const SettingCardLayout({
    Key? key,
    required this.settingChild,
  }) : super(key: key);

  final Widget settingChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.dp),
      decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.grey.withOpacity(.4)),
          borderRadius: BorderRadius.circular(24.dp),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 1),
              color: AppColor.grey.withOpacity(0.4),
            ),
          ]),
      child: settingChild,
    );
  }
}
