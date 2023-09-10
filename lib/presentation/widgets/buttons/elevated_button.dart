import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/presentation/styles/colors.dart';

import '../common_texts/elevated_text_button.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColor.primaryColor,
    this.textStyle,
    this.height,
    this.width,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.iconColor,
    this.icon,
    this.isVisible = true,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final double? height;
  final Alignment alignment;
  final IconData? icon;
  final double? width;
  final double? borderRadius;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 35.w,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: alignment,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.0.dp)),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(4.dp),
          child: icon != null
              ? Row(
                  children: [
                    if (translator.activeLanguageCode == 'en')
                      Expanded(
                          child: Icon(icon,
                              size: 20.dp, color: iconColor ?? AppColor.white)),
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: ElevatedTextButton(text: text, textStyle: textStyle),
                    ),
                    if (translator.activeLanguageCode == 'ar')
                      Expanded(
                        child: Icon(icon,
                            size: 20.dp, color: iconColor ?? AppColor.white)),
                  ],
                )
              : ElevatedTextButton(text: text, textStyle: textStyle),
        ),
      ),
    );
  }
}
