import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/presentation/router/app_router_names.dart';

import '../../constants/app_icons.dart';
import '../styles/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onTapFirstIcon,
    this.onTapNotification,
    this.textStyle,
    this.isEndIconVisible = true,
    this.firstIcon = Icons.arrow_back_ios,
  }) : super(key: key);

  final String title;
  final TextStyle? textStyle;
  final void Function()? onTapFirstIcon;
  final void Function()? onTapNotification;
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
                  iconSize: 24.dp,
                  padding: EdgeInsets.zero,
                  color: AppColor.pineGreen,
                  icon: Icon(firstIcon, size: 24.dp),
                  onPressed: onTapFirstIcon ?? () => Navigator.pop(context),
                )
              : InkWell(
                  borderRadius: BorderRadius.zero,
                  radius: 0.0,
                  onTap: onTapFirstIcon,
                  child: SvgPicture.asset(AppIcons.stairMenu,
                      height: 24.dp, width: 24.dp),
                ),
        ),
        Expanded(
          flex: 6,
          child: Center(
              child: Text(title,
                  style: textStyle ?? Theme.of(context).textTheme.headline3)),
        ),
        Expanded(
          flex: 1,
          child: Visibility(
            visible: isEndIconVisible,
            child: InkWell(
              borderRadius: BorderRadius.zero,
              radius: 0.0,
              onTap: () =>
                  onTapNotification ??
                  Navigator.of(context).pushNamed(AppRouterNames.rNotification),
              child: SvgPicture.asset(AppIcons.notificationSetting,
                  height: 22.dp, width: 22.dp),
            ),
          ),
        )
      ],
    );
  }
}
