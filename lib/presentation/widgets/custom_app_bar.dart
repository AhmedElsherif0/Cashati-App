import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onTapBack,
    this.onTanNotification,
    this.textStyle,
    this.isEndIconVisible = true,
  }) : super(key: key);

  final String title;
  final TextStyle? textStyle;
  final Function() onTapBack;
  final Function()? onTanNotification;
  final bool isEndIconVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            color: AppColor.pineGreen,
            icon: const Icon(Icons.arrow_back_ios, size: 30),
            onPressed: onTapBack,
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
                height: 24.sp,
                width: 24.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}
