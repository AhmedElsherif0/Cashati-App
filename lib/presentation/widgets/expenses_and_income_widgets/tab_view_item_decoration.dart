import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    Key? key,
    required this.text,
    this.backGroundColor,
    this.textColor,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final Color? backGroundColor;
  final Color? textColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(12.sp),
          border: Border.all(width: 1.sp, color: AppColor.primaryColor),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: textColor??AppColor.primaryColor)),
        ),
      ),
    );
  }
}
