import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/presentation/styles/colors.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton(
      {Key? key, required this.iconData, required this.onTap, this.iconColor})
      : super(key: key);
  final IconData iconData;
  final void Function() onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: AppColor.middleGrey.withOpacity(0.7)),
        child: Icon(iconData, color: iconColor ?? AppColor.darkGrey, size: 15.dp),
      ),
    );
  }
}
