import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import '../styles/colors.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String? text;
  final String icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          const Spacer(),
          SizedBox(
            height: 7.h,
            width: 14.w,
              child: SvgPicture.asset(icon,
                  fit: BoxFit.contain, color: AppColor.primaryColor),
          ),
          SizedBox(width: 2.w),
          Expanded(
            flex: 8,
            child:
                Text(text ?? '', style: Theme.of(context).textTheme.headline6),
          )
        ],
      ),
    );
  }
}
