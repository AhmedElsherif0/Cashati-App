import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final AlignmentGeometry alignment;
  final TextStyle? textStyle;

  const CustomTextButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.alignment = Alignment.center,
      this.textStyle = const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
