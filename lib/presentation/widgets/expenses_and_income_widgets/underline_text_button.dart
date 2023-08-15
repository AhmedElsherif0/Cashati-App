import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../styles/colors.dart';

class UnderLineTextButton extends StatelessWidget {
  const UnderLineTextButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.textStyle,
    this.decorationColor = AppColor.pineGreen,
    this.padding,
    this.fontSize,
    this.borderLineColor = AppColor.white, this.borderPadding,
  }) : super(key: key);

  final void Function()? onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color? decorationColor;
  final Color borderLineColor;
  final EdgeInsets? padding;
  final double? fontSize;
  final EdgeInsetsGeometry? borderPadding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: decorationColor,
        padding: padding ?? EdgeInsets.only(right: 8.dp),
        textStyle: TextStyle(
          color: AppColor.pineGreen,
          fontSize: fontSize ?? 12.4.dp,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: onPressed,
      child: Container(
        padding: borderPadding,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: borderLineColor, width: 1.5.dp),
            ),
          ),
          child: Text(text)),
    );
  }
}
