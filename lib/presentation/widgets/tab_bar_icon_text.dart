import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

class TabBarIconText extends StatelessWidget {
  const TabBarIconText(
      {Key? key,
      required this.svgIcon,
      required this.name,
      required this.isClicked})
      : super(key: key);

  final String svgIcon;
  final String name;
  final bool isClicked;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        SvgPicture.asset(svgIcon,
            height: 40.sp,
            width: 40.sp,
            color: isClicked ? AppColor.primaryColor : AppColor.pinkishGrey),
        Text(name,
            style: isClicked
                ? textTheme.headline6
                : textTheme.headline6?.copyWith(color: AppColor.pinkishGrey))
      ],
    );
  }
}
