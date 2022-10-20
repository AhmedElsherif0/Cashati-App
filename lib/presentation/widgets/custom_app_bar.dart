import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onTapFirstIcon,
    this.onTanNotification,
    this.textStyle,
    this.isEndIconVisible = true,
    this.firstIcon = Icons.arrow_back_ios,
  }) : super(key: key);

  final String title;
  final TextStyle? textStyle;
  final void Function()? onTapFirstIcon;
  final void Function()? onTanNotification;
  final IconData? firstIcon;
  final bool isEndIconVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: firstIcon == Icons.arrow_back_ios
              ? IconButton(
                  color: AppColor.pineGreen,
                  icon: Icon(firstIcon, size: 24.sp),
                  onPressed: onTapFirstIcon ?? () => Navigator.of(context).pop,
                )
              : InkWell(
                  borderRadius: BorderRadius.zero,
                  radius: 0.0,
                  onTap: onTapFirstIcon,
                  child: SvgPicture.asset('assets/icons/Group.svg',
                      height: 24.sp, width: 24.sp),
                ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Text(title,
                style: textStyle ?? Theme.of(context).textTheme.headline4),
          ),
        ),
        Expanded(
          flex: 1,
          child: Visibility(
            visible: isEndIconVisible,
            child: InkWell(
              borderRadius: BorderRadius.zero,
              radius: 0.0,
              onTap: onTanNotification,
              child: SvgPicture.asset(
                'assets/images/notification.svg',
                height: 22.sp,
                width: 22.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}
