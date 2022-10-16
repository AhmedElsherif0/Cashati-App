import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class UnderLineTextButton extends StatelessWidget {
  const UnderLineTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textStyle,
  }) : super(key: key);
  final void Function() onPressed;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        textStyle: TextStyle(
            color: AppColor.pineGreen,
            fontSize: 12.4.sp,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.solid,
            decorationThickness: 2,
            decorationColor: AppColor.pineGreen),
        foregroundColor: AppColor.pineGreen,
        padding: EdgeInsets.zero,
      ),
      child: Text(text, style: textStyle),
    );
  }
}
