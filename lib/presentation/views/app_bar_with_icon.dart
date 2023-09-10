import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/colors.dart';

class AppBarWithIcon extends StatelessWidget {
  const AppBarWithIcon(
      {Key? key,
      required this.titleIcon,
      required this.titleName,
      this.textStyle,
      this.onTapFirstIcon,
      this.firstIcon,
      this.onTapActionIcon,
      this.actionIconFunction,
      required this.actionIcon})
      : super(key: key);
  final String titleIcon;
  final String titleName;
  final TextStyle? textStyle;
  final void Function()? onTapFirstIcon;
  final void Function()? onTapActionIcon;
  final void Function()? actionIconFunction;
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
                  iconSize: 24.dp,
                  padding: EdgeInsets.zero,
                  color: AppColor.pineGreen,
                  icon: Icon(firstIcon, size: 24.dp),
                  onPressed: onTapFirstIcon ?? () => Navigator.pop(context))
              : InkWell(
                  borderRadius: BorderRadius.zero,
                  radius: 0.0,
                  onTap: onTapFirstIcon,
                  child: SvgPicture.asset('assets/icons/stair_menu.svg',
                      height: 22.dp, width: 22.dp)),
        ),
        const Spacer(),
        Center(
          child: Row(
            children: [
              Text(titleName,
                  style: textStyle ?? Theme.of(context).textTheme.headline3),
              SizedBox(width: 1.w),
              SvgPicture.asset(titleIcon, height: 22.dp, width: 24.dp)
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 1,
          child: Visibility(
            visible: actionIcon.isNotEmpty,
            replacement: const SizedBox(),
            child: InkWell(
                onTap: actionIconFunction,
                child: SvgPicture.asset(actionIcon, height: 22.dp, width: 22.dp)),
          ),
        )
      ],
    );
  }
}