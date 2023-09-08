import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/colors.dart';

class SettingsChosenComponent extends StatelessWidget {
  const SettingsChosenComponent({
    super.key,
     this.icon,
    required this.iconName,
    required this.onTap,
    this.isPressed = false,
  });

  final String? icon;
  final String iconName;
  final bool isPressed;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      highlightColor: AppColor.dividerColor.withOpacity(.5),
      onPressed: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: isPressed
                ? AppColor.dividerColor.withOpacity(.5)
                : Colors.transparent),
        child: Row(
          children: [
            if(icon !=null)
            SvgPicture.asset(icon??'',
                color: AppColor.pineGreen, height: 30, width: 30),
            SizedBox(width: 2.w),
            Text(iconName,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
