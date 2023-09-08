import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/presentation/styles/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final AlignmentGeometry alignment;
  final TextStyle? textStyle;
  final IconData? icon;
  final bool isVisible;

  const CustomTextButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.alignment = Alignment.center,
      this.textStyle,
      this.icon,
      this.isVisible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: isVisible,
            child: Icon(icon, color: AppColor.primaryColor, size: 16.dp),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
