import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../../styles/colors.dart';
import '../../styles/decorations.dart';

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
    return Tab(
      height: 6.h,
      child: InkWell(
        onTap: onTap,
        child: DecoratedBox(
          decoration:
              AppDecorations.defBoxDecoration.copyWith(color: backGroundColor),
          child: Align(
            alignment: Alignment.center,
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: textColor ?? AppColor.primaryColor),),
          ),
        ),
      ),
    );
  }
}
