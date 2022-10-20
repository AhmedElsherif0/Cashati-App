import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class UnderLineTextButton extends StatelessWidget {
  const UnderLineTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textStyle  , this.decorationColor = AppColor.pineGreen,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color? decorationColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor:decorationColor,
        padding: EdgeInsets.zero,
        textStyle: TextStyle(
            color: AppColor.pineGreen,
            fontSize: 12.4.sp,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.solid,
            decorationThickness: 2,
            decorationColor:decorationColor,
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: textStyle),
    );
  }
}
