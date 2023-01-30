import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class AppBarWithIcon extends StatelessWidget {
  const AppBarWithIcon(
      {Key? key,
      required this.titleIcon,
      required this.titleName,
      this.textStyle,
      this.onTapFirstIcon,
      this.firstIcon,
      this.onTapActionIcon,
      required this.actionIcon})
      : super(key: key);
  final String titleIcon;
  final String titleName;
  final TextStyle? textStyle;
  final void Function()? onTapFirstIcon;
  final void Function()? onTapActionIcon;
  final IconData? firstIcon;
  final String actionIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: firstIcon == Icons.arrow_back_ios
              ? IconButton(
            iconSize: 24.sp,
            padding: EdgeInsets.zero,
            color: AppColor.pineGreen,
            icon: Icon(firstIcon, size: 24.sp),
            onPressed: onTapFirstIcon ?? () => Navigator.pop(context),
          )
              : InkWell(
            borderRadius: BorderRadius.zero,
            radius: 0.0,
            onTap: onTapFirstIcon,
            child: SvgPicture.asset('assets/icons/stair_menu.svg',
                height: 22.sp, width: 22.sp),
          ),
        ),
        Center(
          child: Row(
            children: [
              Text(titleName,
                  style: textStyle ?? Theme.of(context).textTheme.headline3),
              SizedBox(
                width: 1.w,
              ),
              SvgPicture.asset(titleIcon, height: 22.sp, width: 24.sp,)

            ],
          ),),
        Expanded(
          flex: 1,
          child:  Visibility(
            visible: actionIcon.isNotEmpty,
            child: InkWell(
              onTap: (){},
                child: SvgPicture.asset(actionIcon, height: 22.sp, width: 22.sp)),
            replacement: SizedBox(),
          ),
        )
      ],
    );
  }

}
